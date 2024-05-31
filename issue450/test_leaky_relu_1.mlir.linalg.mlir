#map = affine_map<() -> ()>
#map1 = affine_map<(d0, d1, d2) -> ()>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_leaky_relu(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %cst = arith.constant dense<0> : tensor<i64>
    %cst_0 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%cst : tensor<i64>) outs(%0 : tensor<f32>) {
    ^bb0(%in: i64, %out: f32):
      %7 = arith.sitofp %in : i64 to f32
      linalg.yield %7 : f32
    } -> tensor<f32>
    %2 = tensor.empty() : tensor<3x4x5xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1, %arg0 : tensor<f32>, tensor<3x4x5xf32>) outs(%2 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %7 = arith.cmpf ogt, %in, %in_1 : f32
      %8 = arith.select %7, %in, %in_1 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    %4 = linalg.generic {indexing_maps = [#map1, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1, %arg0 : tensor<f32>, tensor<3x4x5xf32>) outs(%2 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %7 = arith.cmpf olt, %in, %in_1 : f32
      %8 = arith.select %7, %in, %in_1 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    %5 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%4 : tensor<3x4x5xf32>) outs(%2 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %7 = arith.mulf %in, %cst_0 : f32
      linalg.yield %7 : f32
    } -> tensor<3x4x5xf32>
    %6 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%3, %5 : tensor<3x4x5xf32>, tensor<3x4x5xf32>) outs(%2 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %7 = arith.addf %in, %in_1 : f32
      linalg.yield %7 : f32
    } -> tensor<3x4x5xf32>
    return %6 : tensor<3x4x5xf32>
  }
}

