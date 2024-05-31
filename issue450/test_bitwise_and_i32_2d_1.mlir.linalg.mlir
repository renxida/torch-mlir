#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_bitwise_and_i32_2d(%arg0: tensor<3x4xi32>, %arg1: tensor<3x4xi32>) -> tensor<3x4xi32> {
    %0 = tensor.empty() : tensor<3x4xi32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4xi32>, tensor<3x4xi32>) outs(%0 : tensor<3x4xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %2 = arith.andi %in, %in_0 : i32
      linalg.yield %2 : i32
    } -> tensor<3x4xi32>
    return %1 : tensor<3x4xi32>
  }
}

