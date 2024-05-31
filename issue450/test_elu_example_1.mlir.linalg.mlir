#map = affine_map<() -> ()>
#map1 = affine_map<(d0) -> ()>
#map2 = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_elu_example(%arg0: tensor<3xf32>) -> tensor<3xf32> {
    %cst = arith.constant dense<0> : tensor<i64>
    %cst_0 = arith.constant 1.000000e+00 : f32
    %cst_1 = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%cst : tensor<i64>) outs(%0 : tensor<f32>) {
    ^bb0(%in: i64, %out: f32):
      %9 = arith.sitofp %in : i64 to f32
      linalg.yield %9 : f32
    } -> tensor<f32>
    %2 = tensor.empty() : tensor<3xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map2, #map2], iterator_types = ["parallel"]} ins(%1, %arg0 : tensor<f32>, tensor<3xf32>) outs(%2 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %9 = arith.cmpf ogt, %in, %in_2 : f32
      %10 = arith.select %9, %in, %in_2 : f32
      linalg.yield %10 : f32
    } -> tensor<3xf32>
    %4 = linalg.generic {indexing_maps = [#map1, #map2, #map2], iterator_types = ["parallel"]} ins(%1, %arg0 : tensor<f32>, tensor<3xf32>) outs(%2 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %9 = arith.cmpf olt, %in, %in_2 : f32
      %10 = arith.select %9, %in, %in_2 : f32
      linalg.yield %10 : f32
    } -> tensor<3xf32>
    %5 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel"]} ins(%4 : tensor<3xf32>) outs(%2 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %9 = math.exp %in : f32
      linalg.yield %9 : f32
    } -> tensor<3xf32>
    %6 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel"]} ins(%5 : tensor<3xf32>) outs(%2 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %9 = arith.subf %in, %cst_0 : f32
      linalg.yield %9 : f32
    } -> tensor<3xf32>
    %7 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel"]} ins(%6 : tensor<3xf32>) outs(%2 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %9 = arith.mulf %in, %cst_1 : f32
      linalg.yield %9 : f32
    } -> tensor<3xf32>
    %8 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel"]} ins(%3, %7 : tensor<3xf32>, tensor<3xf32>) outs(%2 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %9 = arith.addf %in, %in_2 : f32
      linalg.yield %9 : f32
    } -> tensor<3xf32>
    return %8 : tensor<3xf32>
  }
}

