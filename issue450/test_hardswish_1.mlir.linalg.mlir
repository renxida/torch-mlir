#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<() -> ()>
#map2 = affine_map<(d0, d1, d2) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_hardswish(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %cst = arith.constant dense<6> : tensor<i64>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %cst_1 = arith.constant 3.000000e+00 : f32
    %cst_2 = arith.constant 6.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = arith.addf %in, %cst_1 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = arith.cmpf ugt, %in, %cst_0 : f32
      %9 = arith.select %8, %in, %cst_0 : f32
      linalg.yield %9 : f32
    } -> tensor<3x4x5xf32>
    %3 = tensor.empty() : tensor<f32>
    %4 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = []} ins(%cst : tensor<i64>) outs(%3 : tensor<f32>) {
    ^bb0(%in: i64, %out: f32):
      %8 = arith.sitofp %in : i64 to f32
      linalg.yield %8 : f32
    } -> tensor<f32>
    %5 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%2, %4 : tensor<3x4x5xf32>, tensor<f32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %8 = arith.cmpf olt, %in, %in_3 : f32
      %9 = arith.select %8, %in, %in_3 : f32
      linalg.yield %9 : f32
    } -> tensor<3x4x5xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = arith.divf %in, %cst_2 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %arg0 : tensor<3x4x5xf32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %8 = arith.mulf %in, %in_3 : f32
      linalg.yield %8 : f32
    } -> tensor<3x4x5xf32>
    return %7 : tensor<3x4x5xf32>
  }
}

