#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_sum_two_inputs(%arg0: tensor<3xf32>, %arg1: tensor<3xf32>) -> tensor<3xf32> {
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<3xf32>, tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %2 = arith.addf %in, %in_0 : f32
      linalg.yield %2 : f32
    } -> tensor<3xf32>
    return %1 : tensor<3xf32>
  }
}

