#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<() -> ()>
#map3 = affine_map<(d0, d1, d2, d3) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_celu(%arg0: tensor<3x3x3x1xf32>) -> tensor<3x3x3x1xf32> {
    %cst = arith.constant dense<0> : tensor<i64>
    %cst_0 = arith.constant 2.000000e+00 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x3x3x1xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %10 = arith.divf %in, %cst_0 : f32
      linalg.yield %10 : f32
    } -> tensor<3x3x3x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%1 : tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %10 = math.exp %in : f32
      linalg.yield %10 : f32
    } -> tensor<3x3x3x1xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %10 = arith.subf %in, %cst_1 : f32
      linalg.yield %10 : f32
    } -> tensor<3x3x3x1xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%3 : tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %10 = arith.mulf %in, %cst_0 : f32
      linalg.yield %10 : f32
    } -> tensor<3x3x3x1xf32>
    %5 = tensor.empty() : tensor<f32>
    %6 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%cst : tensor<i64>) outs(%5 : tensor<f32>) {
    ^bb0(%in: i64, %out: f32):
      %10 = arith.sitofp %in : i64 to f32
      linalg.yield %10 : f32
    } -> tensor<f32>
    %7 = linalg.generic {indexing_maps = [#map3, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%6, %4 : tensor<f32>, tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %10 = arith.cmpf olt, %in, %in_2 : f32
      %11 = arith.select %10, %in, %in_2 : f32
      linalg.yield %11 : f32
    } -> tensor<3x3x3x1xf32>
    %8 = linalg.generic {indexing_maps = [#map3, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%6, %arg0 : tensor<f32>, tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %10 = arith.cmpf ogt, %in, %in_2 : f32
      %11 = arith.select %10, %in, %in_2 : f32
      linalg.yield %11 : f32
    } -> tensor<3x3x3x1xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%8, %7 : tensor<3x3x3x1xf32>, tensor<3x3x3x1xf32>) outs(%0 : tensor<3x3x3x1xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %10 = arith.addf %in, %in_2 : f32
      linalg.yield %10 : f32
    } -> tensor<3x3x3x1xf32>
    return %9 : tensor<3x3x3x1xf32>
  }
}

