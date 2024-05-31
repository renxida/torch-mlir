#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0) -> (d0)>
#map3 = affine_map<(d0) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_max_all_dims_default(%arg0: tensor<4x2xi1>) -> tensor<i1> {
    %c0_i64 = arith.constant 0 : i64
    %true = arith.constant true
    %0 = tensor.empty() : tensor<4xi64>
    %1 = linalg.fill ins(%c0_i64 : i64) outs(%0 : tensor<4xi64>) -> tensor<4xi64>
    %2 = tensor.empty() : tensor<4xi1>
    %3 = linalg.fill ins(%true : i1) outs(%2 : tensor<4xi1>) -> tensor<4xi1>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<4x2xi1>) outs(%3, %1 : tensor<4xi1>, tensor<4xi64>) {
    ^bb0(%in: i1, %out: i1, %out_0: i64):
      %10 = linalg.index 1 : index
      %11 = arith.index_cast %10 : index to i64
      %12 = arith.maxsi %in, %out : i1
      %13 = arith.cmpi sgt, %in, %out : i1
      %14 = arith.select %13, %11, %out_0 : i64
      linalg.yield %12, %14 : i1, i64
    } -> (tensor<4xi1>, tensor<4xi64>)
    %5 = tensor.empty() : tensor<i64>
    %6 = linalg.fill ins(%c0_i64 : i64) outs(%5 : tensor<i64>) -> tensor<i64>
    %7 = tensor.empty() : tensor<i1>
    %8 = linalg.fill ins(%true : i1) outs(%7 : tensor<i1>) -> tensor<i1>
    %9:2 = linalg.generic {indexing_maps = [#map2, #map3, #map3], iterator_types = ["reduction"]} ins(%4#0 : tensor<4xi1>) outs(%8, %6 : tensor<i1>, tensor<i64>) {
    ^bb0(%in: i1, %out: i1, %out_0: i64):
      %10 = linalg.index 0 : index
      %11 = arith.index_cast %10 : index to i64
      %12 = arith.maxsi %in, %out : i1
      %13 = arith.cmpi sgt, %in, %out : i1
      %14 = arith.select %13, %11, %out_0 : i64
      linalg.yield %12, %14 : i1, i64
    } -> (tensor<i1>, tensor<i64>)
    return %9#0 : tensor<i1>
  }
}

