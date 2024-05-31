#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_cast_FLOAT_to_BFLOAT16(%arg0: tensor<3x4xf32>) -> tensor<3x4xbf16> {
    %0 = tensor.empty() : tensor<3x4xbf16>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xf32>) outs(%0 : tensor<3x4xbf16>) {
    ^bb0(%in: f32, %out: bf16):
      %2 = arith.truncf %in : f32 to bf16
      linalg.yield %2 : bf16
    } -> tensor<3x4xbf16>
    return %1 : tensor<3x4xbf16>
  }
}

