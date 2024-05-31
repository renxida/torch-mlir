#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_range_float32_type(%arg0: tensor<f32>, %arg1: tensor<f32>, %arg2: tensor<f32>) -> tensor<2xf32> {
    %extracted = tensor.extract %arg0[] : tensor<f32>
    %0 = arith.extf %extracted : f32 to f64
    %extracted_0 = tensor.extract %arg2[] : tensor<f32>
    %1 = arith.extf %extracted_0 : f32 to f64
    %2 = arith.truncf %0 : f64 to f32
    %3 = arith.truncf %1 : f64 to f32
    %4 = tensor.empty() : tensor<2xf32>
    %5 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%4 : tensor<2xf32>) {
    ^bb0(%out: f32):
      %6 = linalg.index 0 : index
      %7 = arith.index_cast %6 : index to i64
      %8 = arith.sitofp %7 : i64 to f32
      %9 = arith.mulf %3, %8 : f32
      %10 = arith.addf %2, %9 : f32
      linalg.yield %10 : f32
    } -> tensor<2xf32>
    return %5 : tensor<2xf32>
  }
}

