#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_bitshift_left_uint16(%arg0: tensor<3xi16>, %arg1: tensor<3xi16>) -> tensor<3xi16> {
    %0 = tensor.empty() : tensor<3xi16>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<3xi16>, tensor<3xi16>) outs(%0 : tensor<3xi16>) {
    ^bb0(%in: i16, %in_0: i16, %out: i16):
      %2 = arith.shli %in, %in_0 : i16
      linalg.yield %2 : i16
    } -> tensor<3xi16>
    return %1 : tensor<3xi16>
  }
}

