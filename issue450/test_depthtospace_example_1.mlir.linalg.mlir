#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3, d4, d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d3, d2, d1, d4, d5)>
#map2 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d4, d3, d2, d5)>
#map3 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3, d5, d4)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_depthtospace_example(%arg0: tensor<1x8x2x3xf32>) -> tensor<1x2x4x6xf32> {
    %expanded = tensor.expand_shape %arg0 [[0], [1, 2, 3], [4], [5]] output_shape [1, 2, 2, 2, 2, 3] : tensor<1x8x2x3xf32> into tensor<1x2x2x2x2x3xf32>
    %0 = tensor.empty() : tensor<1x2x2x2x2x3xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%expanded : tensor<1x2x2x2x2x3xf32>) outs(%0 : tensor<1x2x2x2x2x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x2x2x2x3xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%1 : tensor<1x2x2x2x2x3xf32>) outs(%0 : tensor<1x2x2x2x2x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x2x2x2x3xf32>
    %3 = tensor.empty() : tensor<1x2x2x2x3x2xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map3], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%2 : tensor<1x2x2x2x2x3xf32>) outs(%3 : tensor<1x2x2x2x3x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x2x2x3x2xf32>
    %collapsed = tensor.collapse_shape %4 [[0], [1], [2, 3], [4, 5]] : tensor<1x2x2x2x3x2xf32> into tensor<1x2x4x6xf32>
    return %collapsed : tensor<1x2x4x6xf32>
  }
}

