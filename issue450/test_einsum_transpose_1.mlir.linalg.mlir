#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_einsum_transpose(%arg0: tensor<3x4xf64>) -> tensor<4x3xf64> {
    %0 = tensor.empty() : tensor<4x3xf64>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xf64>) outs(%0 : tensor<4x3xf64>) {
    ^bb0(%in: f64, %out: f64):
      linalg.yield %in : f64
    } -> tensor<4x3xf64>
    return %1 : tensor<4x3xf64>
  }
}

