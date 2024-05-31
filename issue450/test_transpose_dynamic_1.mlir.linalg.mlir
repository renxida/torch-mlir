#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d2, d1, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_transpose_dynamic(%arg0: tensor<?x32x5x128xf32>) -> tensor<?x5x32x128xf32> {
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x32x5x128xf32>
    %0 = tensor.empty(%dim) : tensor<?x5x32x128xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<?x32x5x128xf32>) outs(%0 : tensor<?x5x32x128xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x5x32x128xf32>
    return %1 : tensor<?x5x32x128xf32>
  }
}

