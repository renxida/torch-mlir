#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_castlike_FLOAT_to_DOUBLE(%arg0: tensor<3x4xf32>, %arg1: tensor<1xf64>) -> tensor<3x4xf64> {
    %0 = tensor.empty() : tensor<3x4xf64>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xf32>) outs(%0 : tensor<3x4xf64>) {
    ^bb0(%in: f32, %out: f64):
      %2 = arith.extf %in : f32 to f64
      linalg.yield %2 : f64
    } -> tensor<3x4xf64>
    return %1 : tensor<3x4xf64>
  }
}

