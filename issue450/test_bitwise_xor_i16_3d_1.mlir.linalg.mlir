#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_bitwise_xor_i16_3d(%arg0: tensor<3x4x5xi16>, %arg1: tensor<3x4x5xi16>) -> tensor<3x4x5xi16> {
    %0 = tensor.empty() : tensor<3x4x5xi16>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5xi16>, tensor<3x4x5xi16>) outs(%0 : tensor<3x4x5xi16>) {
    ^bb0(%in: i16, %in_0: i16, %out: i16):
      %2 = arith.xori %in, %in_0 : i16
      linalg.yield %2 : i16
    } -> tensor<3x4x5xi16>
    return %1 : tensor<3x4x5xi16>
  }
}

