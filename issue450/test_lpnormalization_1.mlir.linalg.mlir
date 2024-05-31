#map = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, d2, d3, d4)>
#map1 = affine_map<(d0, d1, d2, d3, d4) -> (d0, d1, 0, d3, d4)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_lpnormalization(%arg0: tensor<3x4x5x6x7xf32>) -> tensor<3x4x1x6x7xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %cst_1 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x4x1x6x7xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3x4x1x6x7xf32>) -> tensor<3x4x1x6x7xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5x6x7xf32>) outs(%1 : tensor<3x4x1x6x7xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = math.absf %in : f32
      %5 = math.powf %4, %cst_1 : f32
      %6 = arith.addf %5, %out : f32
      linalg.yield %6 : f32
    } -> tensor<3x4x1x6x7xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<3x4x1x6x7xf32>) outs(%0 : tensor<3x4x1x6x7xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = math.powf %in, %cst_0 : f32
      linalg.yield %4 : f32
    } -> tensor<3x4x1x6x7xf32>
    return %3 : tensor<3x4x1x6x7xf32>
  }
}

