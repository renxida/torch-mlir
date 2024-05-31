#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_softsign(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = math.absf %in : f32
      linalg.yield %4 : f32
    } -> tensor<3x4x5xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %4 = arith.addf %in, %cst : f32
      linalg.yield %4 : f32
    } -> tensor<3x4x5xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %2 : tensor<3x4x5xf32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %4 = arith.divf %in, %in_0 : f32
      linalg.yield %4 : f32
    } -> tensor<3x4x5xf32>
    return %3 : tensor<3x4x5xf32>
  }
}

