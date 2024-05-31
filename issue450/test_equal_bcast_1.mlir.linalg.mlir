#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_equal_bcast(%arg0: tensor<3x4x5xi32>, %arg1: tensor<5xi32>) -> tensor<3x4x5xi1> {
    %0 = tensor.empty() : tensor<3x4x5xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5xi32>, tensor<5xi32>) outs(%0 : tensor<3x4x5xi1>) {
    ^bb0(%in: i32, %in_0: i32, %out: i1):
      %2 = arith.cmpi eq, %in, %in_0 : i32
      linalg.yield %2 : i1
    } -> tensor<3x4x5xi1>
    return %1 : tensor<3x4x5xi1>
  }
}

