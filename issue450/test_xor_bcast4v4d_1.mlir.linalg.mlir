#map = affine_map<(d0, d1, d2, d3) -> (0, d1, 0, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, 0, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_xor_bcast4v4d(%arg0: tensor<1x4x1x6xi1>, %arg1: tensor<3x1x5x6xi1>) -> tensor<3x4x5x6xi1> {
    %false = arith.constant false
    %0 = tensor.empty() : tensor<3x4x5x6xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<1x4x1x6xi1>, tensor<3x1x5x6xi1>) outs(%0 : tensor<3x4x5x6xi1>) {
    ^bb0(%in: i1, %in_0: i1, %out: i1):
      %2 = arith.cmpi ne, %in, %false : i1
      %3 = arith.cmpi ne, %in_0, %false : i1
      %4 = arith.xori %2, %3 : i1
      linalg.yield %4 : i1
    } -> tensor<3x4x5x6xi1>
    return %1 : tensor<3x4x5x6xi1>
  }
}

