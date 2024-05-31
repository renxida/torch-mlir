module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @ints_constant() -> tensor<2xi64> {
    %cst = arith.constant dense<[7, 9]> : tensor<2xi64>
    return %cst : tensor<2xi64>
  }
}

