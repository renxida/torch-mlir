#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
#map2 = affine_map<(d0) -> (d0)>
#map3 = affine_map<(d0) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_min_all_dims_default(%arg0: tensor<4x2xi1>) -> tensor<i1> {
    %c0_i32 = arith.constant 0 : i32
    %false = arith.constant false
    %0 = tensor.empty() : tensor<4xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4xi32>) -> tensor<4xi32>
    %2 = tensor.empty() : tensor<4xi1>
    %3 = linalg.fill ins(%false : i1) outs(%2 : tensor<4xi1>) -> tensor<4xi1>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<4x2xi1>) outs(%3, %1 : tensor<4xi1>, tensor<4xi32>) {
    ^bb0(%in: i1, %out: i1, %out_0: i32):
      %10 = linalg.index 1 : index
      %11 = arith.index_cast %10 : index to i32
      %12 = arith.minsi %in, %out : i1
      %13 = arith.cmpi slt, %in, %out : i1
      %14 = arith.select %13, %11, %out_0 : i32
      linalg.yield %12, %14 : i1, i32
    } -> (tensor<4xi1>, tensor<4xi32>)
    %5 = tensor.empty() : tensor<i32>
    %6 = linalg.fill ins(%c0_i32 : i32) outs(%5 : tensor<i32>) -> tensor<i32>
    %7 = tensor.empty() : tensor<i1>
    %8 = linalg.fill ins(%false : i1) outs(%7 : tensor<i1>) -> tensor<i1>
    %9:2 = linalg.generic {indexing_maps = [#map2, #map3, #map3], iterator_types = ["reduction"]} ins(%4#0 : tensor<4xi1>) outs(%8, %6 : tensor<i1>, tensor<i32>) {
    ^bb0(%in: i1, %out: i1, %out_0: i32):
      %10 = linalg.index 0 : index
      %11 = arith.index_cast %10 : index to i32
      %12 = arith.minsi %in, %out : i1
      %13 = arith.cmpi slt, %in, %out : i1
      %14 = arith.select %13, %11, %out_0 : i32
      linalg.yield %12, %14 : i1, i32
    } -> (tensor<i1>, tensor<i32>)
    return %9#0 : tensor<i1>
  }
}

