#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_cast_FLOAT16_to_FLOAT(%arg0: tensor<3x4xf16>) -> tensor<3x4xf32> {
    %0 = tensor.empty() : tensor<3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xf16>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f16, %out: f32):
      %2 = arith.extf %in : f16 to f32
      linalg.yield %2 : f32
    } -> tensor<3x4xf32>
    return %1 : tensor<3x4xf32>
  }
}

