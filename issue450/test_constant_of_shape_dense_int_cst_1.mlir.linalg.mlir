module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_constant_of_shape_dense_int_cst() -> tensor<2x3x4xi64> {
    %cst = arith.constant dense<3> : tensor<2x3x4xi64>
    return %cst : tensor<2x3x4xi64>
  }
}

