#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, 0, 0)>
#map2 = affine_map<(d0, d1, d2, d3) -> (0, d1, 0, 0)>
#map3 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
#map4 = affine_map<(d0, d1, d2, d3) -> (0, d1, 0, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_instancenorm(%arg0: tensor<1x2x1x3xf32>, %arg1: tensor<2xf32>, %arg2: tensor<2xf32>) -> tensor<1x2x1x3xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 3.000000e+00 : f32
    %cst_1 = arith.constant 9.99999974E-6 : f32
    %0 = tensor.empty() : tensor<1x2x1x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x2x1x1xf32>) -> tensor<1x2x1x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction", "reduction"]} ins(%arg0 : tensor<1x2x1x3xf32>) outs(%1 : tensor<1x2x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %18 = arith.addf %in, %out : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x1xf32>
    %3 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<1x2x1x1xf32>) outs(%0 : tensor<1x2x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %18 = arith.divf %in, %cst_0 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x1xf32>
    %4 = tensor.empty() : tensor<1x2x1x3xf32>
    %5 = linalg.generic {indexing_maps = [#map3, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%3 : tensor<1x2x1x1xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x1x3xf32>
    %6 = linalg.generic {indexing_maps = [#map4, #map4, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0, %5 : tensor<1x2x1x3xf32>, tensor<1x2x1x3xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %18 = arith.subf %in, %in_3 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x3xf32>
    %7 = linalg.generic {indexing_maps = [#map4, #map4, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%6, %6 : tensor<1x2x1x3xf32>, tensor<1x2x1x3xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %18 = arith.mulf %in, %in_3 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x3xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction", "reduction"]} ins(%7 : tensor<1x2x1x3xf32>) outs(%1 : tensor<1x2x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %18 = arith.addf %in, %out : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x1xf32>
    %9 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%8 : tensor<1x2x1x1xf32>) outs(%0 : tensor<1x2x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %18 = arith.divf %in, %cst_0 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x1xf32>
    %10 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%9 : tensor<1x2x1x1xf32>) outs(%0 : tensor<1x2x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %18 = arith.addf %in, %cst_1 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x1xf32>
    %11 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%10 : tensor<1x2x1x1xf32>) outs(%0 : tensor<1x2x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %18 = math.rsqrt %in : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x1xf32>
    %12 = linalg.generic {indexing_maps = [#map3, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%11 : tensor<1x2x1x1xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x1x3xf32>
    %13 = linalg.generic {indexing_maps = [#map4, #map4, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%6, %12 : tensor<1x2x1x3xf32>, tensor<1x2x1x3xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %18 = arith.mulf %in, %in_3 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x3xf32>
    %expanded = tensor.expand_shape %arg1 [[0, 1, 2, 3]] output_shape [1, 2, 1, 1] : tensor<2xf32> into tensor<1x2x1x1xf32>
    %14 = linalg.generic {indexing_maps = [#map3, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded : tensor<1x2x1x1xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x1x3xf32>
    %expanded_2 = tensor.expand_shape %arg2 [[0, 1, 2, 3]] output_shape [1, 2, 1, 1] : tensor<2xf32> into tensor<1x2x1x1xf32>
    %15 = linalg.generic {indexing_maps = [#map3, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%expanded_2 : tensor<1x2x1x1xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x1x3xf32>
    %16 = linalg.generic {indexing_maps = [#map4, #map4, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%13, %14 : tensor<1x2x1x3xf32>, tensor<1x2x1x3xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %18 = arith.mulf %in, %in_3 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x3xf32>
    %17 = linalg.generic {indexing_maps = [#map4, #map4, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%16, %15 : tensor<1x2x1x3xf32>, tensor<1x2x1x3xf32>) outs(%4 : tensor<1x2x1x3xf32>) {
    ^bb0(%in: f32, %in_3: f32, %out: f32):
      %18 = arith.addf %in, %in_3 : f32
      linalg.yield %18 : f32
    } -> tensor<1x2x1x3xf32>
    return %17 : tensor<1x2x1x3xf32>
  }
}

