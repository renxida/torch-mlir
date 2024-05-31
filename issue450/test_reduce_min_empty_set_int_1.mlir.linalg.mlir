module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_min_empty_set_int(%arg0: tensor<2x0x4xi32>, %arg1: tensor<1xi64>) -> tensor<2x1x4xi32> {
    %cst = arith.constant dense<2147483647> : tensor<2x1x4xi32>
    return %cst : tensor<2x1x4xi32>
  }
}

