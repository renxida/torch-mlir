#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_castlike_DOUBLE_to_FLOAT(%arg0: tensor<3x4xf64>, %arg1: tensor<1xf32>) -> tensor<3x4xf32> {
    %0 = tensor.empty() : tensor<3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xf64>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f64, %out: f32):
      %2 = arith.truncf %in : f64 to f32
      linalg.yield %2 : f32
    } -> tensor<3x4xf32>
    return %1 : tensor<3x4xf32>
  }
}

