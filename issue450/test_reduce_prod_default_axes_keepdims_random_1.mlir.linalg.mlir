#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (0, d1, d2)>
#map2 = affine_map<(d0, d1, d2) -> (d0, 0, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_prod_default_axes_keepdims_random(%arg0: tensor<3x2x2xf32>) -> tensor<1x1x1xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x2x2xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x2x2xf32>) -> tensor<1x2x2xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "parallel", "parallel"]} ins(%arg0 : tensor<3x2x2xf32>) outs(%1 : tensor<1x2x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      %9 = arith.mulf %in, %out : f32
      linalg.yield %9 : f32
    } -> tensor<1x2x2xf32>
    %3 = tensor.empty() : tensor<1x1x2xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<1x1x2xf32>) -> tensor<1x1x2xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map2], iterator_types = ["parallel", "reduction", "parallel"]} ins(%2 : tensor<1x2x2xf32>) outs(%4 : tensor<1x1x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      %9 = arith.mulf %in, %out : f32
      linalg.yield %9 : f32
    } -> tensor<1x1x2xf32>
    %6 = tensor.empty() : tensor<1x1x1xf32>
    %7 = linalg.fill ins(%cst : f32) outs(%6 : tensor<1x1x1xf32>) -> tensor<1x1x1xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map3], iterator_types = ["parallel", "parallel", "reduction"]} ins(%5 : tensor<1x1x2xf32>) outs(%7 : tensor<1x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %9 = arith.mulf %in, %out : f32
      linalg.yield %9 : f32
    } -> tensor<1x1x1xf32>
    return %8 : tensor<1x1x1xf32>
  }
}

