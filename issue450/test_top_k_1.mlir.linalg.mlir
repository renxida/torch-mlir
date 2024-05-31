#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_top_k(%arg0: tensor<3x4xf32>, %arg1: tensor<1xi64>) -> (tensor<3x3xf32>, tensor<3x3xi64>) {
    %0 = tensor.empty() : tensor<3x4xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel"]} outs(%0 : tensor<3x4xi64>) {
    ^bb0(%out: i64):
      %3 = linalg.index 1 : index
      %4 = arith.index_cast %3 : index to i64
      linalg.yield %4 : i64
    } -> tensor<3x4xi64>
    %2:2 = tm_tensor.sort dimension(1) outs(%arg0, %1 : tensor<3x4xf32>, tensor<3x4xi64>) {
    ^bb0(%arg2: f32, %arg3: f32, %arg4: i64, %arg5: i64):
      %3 = arith.cmpf oge, %arg2, %arg3 : f32
      tm_tensor.yield %3 : i1
    } -> tensor<3x4xf32>, tensor<3x4xi64>
    %extracted_slice = tensor.extract_slice %2#0[0, 0] [3, 3] [1, 1] : tensor<3x4xf32> to tensor<3x3xf32>
    %extracted_slice_0 = tensor.extract_slice %2#1[0, 0] [3, 3] [1, 1] : tensor<3x4xi64> to tensor<3x3xi64>
    return %extracted_slice, %extracted_slice_0 : tensor<3x3xf32>, tensor<3x3xi64>
  }
}

