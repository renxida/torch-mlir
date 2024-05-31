#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_clip_default_int8_min(%arg0: tensor<3x4x5xi8>, %arg1: tensor<i8>) -> tensor<3x4x5xi8> {
    %0 = tensor.empty() : tensor<3x4x5xi8>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5xi8>, tensor<i8>) outs(%0 : tensor<3x4x5xi8>) {
    ^bb0(%in: i8, %in_0: i8, %out: i8):
      %2 = arith.cmpi slt, %in, %in_0 : i8
      %3 = arith.select %2, %in_0, %in : i8
      linalg.yield %3 : i8
    } -> tensor<3x4x5xi8>
    return %1 : tensor<3x4x5xi8>
  }
}

