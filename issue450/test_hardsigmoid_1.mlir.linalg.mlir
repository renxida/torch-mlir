#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<() -> ()>
#map2 = affine_map<(d0, d1, d2) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_hardsigmoid(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %cst = arith.constant dense<1> : tensor<i64>
    %cst_0 = arith.constant 3.000000e-01 : f32
    %cst_1 = arith.constant dense<0> : tensor<i64>
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %7 = arith.addf %in, %cst_0 : f32
      linalg.yield %7 : f32
    } -> tensor<3x4x5xf32>
    %2 = tensor.empty() : tensor<f32>
    %3 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = []} ins(%cst : tensor<i64>) outs(%2 : tensor<f32>) {
    ^bb0(%in: i64, %out: f32):
      %7 = arith.sitofp %in : i64 to f32
      linalg.yield %7 : f32
    } -> tensor<f32>
    %4 = linalg.generic {indexing_maps = [#map2, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%3, %1 : tensor<f32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %7 = arith.cmpf olt, %in, %in_2 : f32
      %8 = arith.select %7, %in, %in_2 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    %5 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = []} ins(%cst_1 : tensor<i64>) outs(%2 : tensor<f32>) {
    ^bb0(%in: i64, %out: f32):
      %7 = arith.sitofp %in : i64 to f32
      linalg.yield %7 : f32
    } -> tensor<f32>
    %6 = linalg.generic {indexing_maps = [#map2, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %4 : tensor<f32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %7 = arith.cmpf ogt, %in, %in_2 : f32
      %8 = arith.select %7, %in, %in_2 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    return %6 : tensor<3x4x5xf32>
  }
}

