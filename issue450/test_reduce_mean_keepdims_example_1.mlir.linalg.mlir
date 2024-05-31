#map = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, d1, d2, d3, d4, d5, d6)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, 0, d2, 0, d4, d5, 0)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5, d6) -> (d0, 0, d2, 0, 0, d5, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_mean_keepdims_example(%arg0: tensor<3x2x4x5x1x6x7xf32>, %arg1: tensor<3xi64>) -> tensor<3x1x4x1x1x6x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 7.000000e+01 : f32
    %0 = tensor.empty() : tensor<3x1x4x1x1x6x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3x1x4x1x1x6x1xf32>) -> tensor<3x1x4x1x1x6x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "reduction", "parallel", "reduction", "parallel", "parallel", "reduction"]} ins(%arg0 : tensor<3x2x4x5x1x6x7xf32>) outs(%1 : tensor<3x1x4x1x1x6x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.addf %in, %out : f32
      linalg.yield %4 : f32
    } -> tensor<3x1x4x1x1x6x1xf32>
    %3 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<3x1x4x1x1x6x1xf32>) outs(%0 : tensor<3x1x4x1x1x6x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.divf %in, %cst_0 : f32
      linalg.yield %4 : f32
    } -> tensor<3x1x4x1x1x6x1xf32>
    return %3 : tensor<3x1x4x1x1x6x1xf32>
  }
}

