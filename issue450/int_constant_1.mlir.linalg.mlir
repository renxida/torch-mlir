module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @int_constant() -> tensor<i64> {
    %cst = arith.constant dense<79> : tensor<i64>
    return %cst : tensor<i64>
  }
}

