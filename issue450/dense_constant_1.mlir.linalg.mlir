module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @dense_constant() -> tensor<1xi64> {
    %cst = arith.constant dense<13> : tensor<1xi64>
    return %cst : tensor<1xi64>
  }
}

