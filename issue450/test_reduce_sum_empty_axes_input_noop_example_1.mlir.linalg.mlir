module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_sum_empty_axes_input_noop_example(%arg0: tensor<3x2x2xf32>, %arg1: tensor<0xi64>) -> tensor<3x2x2xf32> {
    return %arg0 : tensor<3x2x2xf32>
  }
}

