#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_min_attr(%arg0: tensor<4x2xi1>) -> tensor<4xi1> {
    %c0_i32 = arith.constant 0 : i32
    %false = arith.constant false
    %0 = tensor.empty() : tensor<4xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4xi32>) -> tensor<4xi32>
    %2 = tensor.empty() : tensor<4xi1>
    %3 = linalg.fill ins(%false : i1) outs(%2 : tensor<4xi1>) -> tensor<4xi1>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<4x2xi1>) outs(%3, %1 : tensor<4xi1>, tensor<4xi32>) {
    ^bb0(%in: i1, %out: i1, %out_0: i32):
      %5 = linalg.index 1 : index
      %6 = arith.index_cast %5 : index to i32
      %7 = arith.minsi %in, %out : i1
      %8 = arith.cmpi slt, %in, %out : i1
      %9 = arith.select %8, %6, %out_0 : i32
      linalg.yield %7, %9 : i1, i32
    } -> (tensor<4xi1>, tensor<4xi32>)
    return %4#0 : tensor<4xi1>
  }
}

