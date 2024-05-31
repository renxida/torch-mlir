#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_softplus(%arg0: tensor<3xf32>) -> tensor<3xf32> {
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = math.exp %in : f32
      linalg.yield %3 : f32
    } -> tensor<3xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = math.log1p %in : f32
      linalg.yield %3 : f32
    } -> tensor<3xf32>
    return %2 : tensor<3xf32>
  }
}

