module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @dense_constant_i1() -> tensor<5xi1> {
    %cst = arith.constant dense<[true, false, false, true, true]> : tensor<5xi1>
    return %cst : tensor<5xi1>
  }
}

