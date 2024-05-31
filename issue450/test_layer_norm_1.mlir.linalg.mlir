#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_layer_norm(%arg0: tensor<3x4xf32>, %arg1: tensor<3x4xf32>, %arg2: tensor<3x4xf32>) -> (tensor<3x4xf32>, tensor<1x1xf32>, tensor<1x1xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.200000e+01 : f32
    %cst_1 = arith.constant 9.99999974E-6 : f32
    %0 = tensor.empty() : tensor<1x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x1xf32>) -> tensor<1x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction"]} ins(%arg0 : tensor<3x4xf32>) outs(%1 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.addf %in, %out : f32
      linalg.yield %16 : f32
    } -> tensor<1x1xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<1x1xf32>) outs(%0 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.divf %in, %cst_0 : f32
      linalg.yield %16 : f32
    } -> tensor<1x1xf32>
    %4 = tensor.empty() : tensor<3x4xf32>
    %5 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel"]} ins(%3 : tensor<1x1xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x4xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %5 : tensor<3x4xf32>, tensor<3x4xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %16 = arith.subf %in, %in_2 : f32
      linalg.yield %16 : f32
    } -> tensor<3x4xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%6, %6 : tensor<3x4xf32>, tensor<3x4xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %16 = arith.mulf %in, %in_2 : f32
      linalg.yield %16 : f32
    } -> tensor<3x4xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction"]} ins(%7 : tensor<3x4xf32>) outs(%1 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.addf %in, %out : f32
      linalg.yield %16 : f32
    } -> tensor<1x1xf32>
    %9 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel"]} ins(%8 : tensor<1x1xf32>) outs(%0 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.divf %in, %cst_0 : f32
      linalg.yield %16 : f32
    } -> tensor<1x1xf32>
    %10 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel"]} ins(%9 : tensor<1x1xf32>) outs(%0 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.addf %in, %cst_1 : f32
      linalg.yield %16 : f32
    } -> tensor<1x1xf32>
    %11 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel"]} ins(%10 : tensor<1x1xf32>) outs(%0 : tensor<1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = math.rsqrt %in : f32
      linalg.yield %16 : f32
    } -> tensor<1x1xf32>
    %12 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel"]} ins(%11 : tensor<1x1xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x4xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%6, %12 : tensor<3x4xf32>, tensor<3x4xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %16 = arith.mulf %in, %in_2 : f32
      linalg.yield %16 : f32
    } -> tensor<3x4xf32>
    %14 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%13, %arg1 : tensor<3x4xf32>, tensor<3x4xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %16 = arith.mulf %in, %in_2 : f32
      linalg.yield %16 : f32
    } -> tensor<3x4xf32>
    %15 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%14, %arg2 : tensor<3x4xf32>, tensor<3x4xf32>) outs(%4 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %16 = arith.addf %in, %in_2 : f32
      linalg.yield %16 : f32
    } -> tensor<3x4xf32>
    return %15, %3, %11 : tensor<3x4xf32>, tensor<1x1xf32>, tensor<1x1xf32>
  }
}

