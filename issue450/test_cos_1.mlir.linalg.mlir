#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_cos(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.cos %in : f32
      linalg.yield %2 : f32
    } -> tensor<3x4x5xf32>
    return %1 : tensor<3x4x5xf32>
  }
}

