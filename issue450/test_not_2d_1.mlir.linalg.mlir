#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_not_2d(%arg0: tensor<3x4xi1>) -> tensor<3x4xi1> {
    %true = arith.constant true
    %0 = tensor.empty() : tensor<3x4xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<3x4xi1>) outs(%0 : tensor<3x4xi1>) {
    ^bb0(%in: i1, %out: i1):
      %2 = arith.xori %in, %true : i1
      linalg.yield %2 : i1
    } -> tensor<3x4xi1>
    return %1 : tensor<3x4xi1>
  }
}

