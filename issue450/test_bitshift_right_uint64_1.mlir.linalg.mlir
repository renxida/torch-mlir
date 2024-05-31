#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_bitshift_right_uint64(%arg0: tensor<3xi64>, %arg1: tensor<3xi64>) -> tensor<3xi64> {
    %0 = tensor.empty() : tensor<3xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<3xi64>, tensor<3xi64>) outs(%0 : tensor<3xi64>) {
    ^bb0(%in: i64, %in_0: i64, %out: i64):
      %2 = arith.shrsi %in, %in_0 : i64
      linalg.yield %2 : i64
    } -> tensor<3xi64>
    return %1 : tensor<3xi64>
  }
}

