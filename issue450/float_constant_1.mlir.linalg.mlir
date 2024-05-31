module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @float_constant() -> tensor<f32> {
    %cst = arith.constant dense<2.500000e-01> : tensor<f32>
    return %cst : tensor<f32>
  }
}

