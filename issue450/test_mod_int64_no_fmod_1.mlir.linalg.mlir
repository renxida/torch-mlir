#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_mod_int64_no_fmod(%arg0: tensor<6xi64>, %arg1: tensor<6xi64>) -> tensor<6xi64> {
    %0 = tensor.empty() : tensor<6xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<6xi64>, tensor<6xi64>) outs(%0 : tensor<6xi64>) {
    ^bb0(%in: i64, %in_0: i64, %out: i64):
      %2 = arith.remsi %in, %in_0 : i64
      linalg.yield %2 : i64
    } -> tensor<6xi64>
    return %1 : tensor<6xi64>
  }
}

