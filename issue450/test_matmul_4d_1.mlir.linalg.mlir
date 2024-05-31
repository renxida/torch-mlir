#map = affine_map<(d0, d1, d2, d3) -> (0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_matmul_4d(%arg0: tensor<1x2x3x4xf32>, %arg1: tensor<1x2x4x3xf32>) -> tensor<1x2x3x3xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x2x3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x2x3x4xf32>) outs(%0 : tensor<1x2x3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x3x4xf32>
    %2 = tensor.empty() : tensor<1x2x4x3xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg1 : tensor<1x2x4x3xf32>) outs(%2 : tensor<1x2x4x3xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<1x2x4x3xf32>
    %collapsed = tensor.collapse_shape %1 [[0, 1], [2], [3]] : tensor<1x2x3x4xf32> into tensor<2x3x4xf32>
    %collapsed_0 = tensor.collapse_shape %3 [[0, 1], [2], [3]] : tensor<1x2x4x3xf32> into tensor<2x4x3xf32>
    %4 = tensor.empty() : tensor<2x3x3xf32>
    %5 = linalg.fill ins(%cst : f32) outs(%4 : tensor<2x3x3xf32>) -> tensor<2x3x3xf32>
    %6 = linalg.batch_matmul ins(%collapsed, %collapsed_0 : tensor<2x3x4xf32>, tensor<2x4x3xf32>) outs(%5 : tensor<2x3x3xf32>) -> tensor<2x3x3xf32>
    %expanded = tensor.expand_shape %6 [[0, 1], [2], [3]] output_shape [1, 2, 3, 3] : tensor<2x3x3xf32> into tensor<1x2x3x3xf32>
    return %expanded : tensor<1x2x3x3xf32>
  }
}

