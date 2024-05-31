#map = affine_map<(d0, d1) -> (0, d1)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_expand_dim2_shape2(%arg0: tensor<1x4xf32>, %arg1: tensor<2xi32>) -> tensor<3x4xf32> {
    %0 = tensor.empty() : tensor<3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<1x4xf32>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<3x4xf32>
    return %1 : tensor<3x4xf32>
  }
}

