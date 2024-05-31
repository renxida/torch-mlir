#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_bitwise_or_i16_4d(%arg0: tensor<3x4x5x6xi8>, %arg1: tensor<3x4x5x6xi8>) -> tensor<3x4x5x6xi8> {
    %0 = tensor.empty() : tensor<3x4x5x6xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5x6xi8>, tensor<3x4x5x6xi8>) outs(%0 : tensor<3x4x5x6xi8>) {
    ^bb0(%in: i8, %in_0: i8, %out: i8):
      %2 = arith.ori %in, %in_0 : i8
      linalg.yield %2 : i8
    } -> tensor<3x4x5x6xi8>
    return %1 : tensor<3x4x5x6xi8>
  }
}

