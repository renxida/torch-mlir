#map = affine_map<() -> ()>
#map1 = affine_map<(d0, d1, d2) -> ()>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_dropout_default_mask(%arg0: tensor<3x4x5xf32>) -> (tensor<3x4x5xf32>, tensor<3x4x5xi1>) {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant dense<1> : tensor<i64>
    %0 = tensor.empty() : tensor<i1>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%cst : tensor<i64>) outs(%0 : tensor<i1>) {
    ^bb0(%in: i64, %out: i1):
      %4 = arith.cmpi ne, %in, %c0_i64 : i64
      linalg.yield %4 : i1
    } -> tensor<i1>
    %2 = tensor.empty() : tensor<3x4x5xi1>
    %3 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1 : tensor<i1>) outs(%2 : tensor<3x4x5xi1>) {
    ^bb0(%in: i1, %out: i1):
      linalg.yield %in : i1
    } -> tensor<3x4x5xi1>
    return %arg0, %3 : tensor<3x4x5xf32>, tensor<3x4x5xi1>
  }
}

