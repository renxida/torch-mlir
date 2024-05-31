#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (0, 0, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_sum_square_default_axes_keepdims_example(%arg0: tensor<3x2x2xf32>, %arg1: tensor<0xi64>) -> tensor<1x1x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x2x2xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg0 : tensor<3x2x2xf32>, tensor<3x2x2xf32>) outs(%0 : tensor<3x2x2xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %5 = arith.mulf %in, %in_0 : f32
      linalg.yield %5 : f32
    } -> tensor<3x2x2xf32>
    %2 = tensor.empty() : tensor<1x1x1xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<1x1x1xf32>) -> tensor<1x1x1xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction", "reduction"]} ins(%1 : tensor<3x2x2xf32>) outs(%3 : tensor<1x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %5 = arith.addf %in, %out : f32
      linalg.yield %5 : f32
    } -> tensor<1x1x1xf32>
    return %4 : tensor<1x1x1xf32>
  }
}

