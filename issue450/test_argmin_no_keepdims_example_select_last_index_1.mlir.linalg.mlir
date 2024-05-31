#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_argmin_no_keepdims_example_select_last_index(%arg0: tensor<2x2xf32>) -> tensor<2xi64> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0_i64 = arith.constant 0 : i64
    %cst_0 = arith.constant 0x7F800000 : f32
    %c1_i64 = arith.constant 1 : i64
    %c1 = arith.constant 1 : index
    %0 = tensor.empty() : tensor<2x2xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x2xf32>) -> tensor<2x2xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<2x2xf32>) outs(%1 : tensor<2x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      %10 = linalg.index 0 : index
      %11 = linalg.index 1 : index
      %12 = arith.subi %c1, %11 : index
      %extracted = tensor.extract %arg0[%10, %12] : tensor<2x2xf32>
      linalg.yield %extracted : f32
    } -> tensor<2x2xf32>
    %3 = tensor.empty() : tensor<2xi64>
    %4 = linalg.fill ins(%c0_i64 : i64) outs(%3 : tensor<2xi64>) -> tensor<2xi64>
    %5 = tensor.empty() : tensor<2xf32>
    %6 = linalg.fill ins(%cst_0 : f32) outs(%5 : tensor<2xf32>) -> tensor<2xf32>
    %7:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "reduction"]} ins(%2 : tensor<2x2xf32>) outs(%6, %4 : tensor<2xf32>, tensor<2xi64>) {
    ^bb0(%in: f32, %out: f32, %out_1: i64):
      %10 = linalg.index 1 : index
      %11 = arith.index_cast %10 : index to i64
      %12 = arith.minimumf %in, %out : f32
      %13 = arith.cmpf olt, %in, %out : f32
      %14 = arith.select %13, %11, %out_1 : i64
      linalg.yield %12, %14 : f32, i64
    } -> (tensor<2xf32>, tensor<2xi64>)
    %8 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel"]} ins(%7#1 : tensor<2xi64>) outs(%3 : tensor<2xi64>) {
    ^bb0(%in: i64, %out: i64):
      %10 = arith.subi %in, %c1_i64 : i64
      linalg.yield %10 : i64
    } -> tensor<2xi64>
    %9 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel"]} ins(%8 : tensor<2xi64>) outs(%3 : tensor<2xi64>) {
    ^bb0(%in: i64, %out: i64):
      %10 = math.absi %in : i64
      linalg.yield %10 : i64
    } -> tensor<2xi64>
    return %9 : tensor<2xi64>
  }
}

