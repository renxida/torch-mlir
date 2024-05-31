#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_cast_DOUBLE_to_FLOAT16(%arg0: tensor<3x4xf64>) -> tensor<3x4xf16> {
    %0 = tensor.empty() : tensor<3x4xf16>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xf64>) outs(%0 : tensor<3x4xf16>) {
    ^bb0(%in: f64, %out: f16):
      %2 = arith.truncf %in : f64 to f16
      linalg.yield %2 : f16
    } -> tensor<3x4xf16>
    return %1 : tensor<3x4xf16>
  }
}

