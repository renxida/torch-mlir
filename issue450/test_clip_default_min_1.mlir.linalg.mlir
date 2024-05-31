#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_clip_default_min(%arg0: tensor<3x4x5xf32>, %arg1: tensor<f32>) -> tensor<3x4x5xf32> {
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5xf32>, tensor<f32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.cmpf ult, %in, %in_0 : f32
      %3 = arith.select %2, %in_0, %in : f32
      linalg.yield %3 : f32
    } -> tensor<3x4x5xf32>
    return %1 : tensor<3x4x5xf32>
  }
}

