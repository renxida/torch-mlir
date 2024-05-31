#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_round(%arg0: tensor<15xf32>) -> tensor<15xf32> {
    %0 = tensor.empty() : tensor<15xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<15xf32>) outs(%0 : tensor<15xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.roundeven %in : f32
      linalg.yield %2 : f32
    } -> tensor<15xf32>
    return %1 : tensor<15xf32>
  }
}

