#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_xor2d(%arg0: tensor<3x4xi1>, %arg1: tensor<3x4xi1>) -> tensor<3x4xi1> {
    %false = arith.constant false
    %0 = tensor.empty() : tensor<3x4xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4xi1>, tensor<3x4xi1>) outs(%0 : tensor<3x4xi1>) {
    ^bb0(%in: i1, %in_0: i1, %out: i1):
      %2 = arith.cmpi ne, %in, %false : i1
      %3 = arith.cmpi ne, %in_0, %false : i1
      %4 = arith.xori %2, %3 : i1
      linalg.yield %4 : i1
    } -> tensor<3x4xi1>
    return %1 : tensor<3x4xi1>
  }
}

