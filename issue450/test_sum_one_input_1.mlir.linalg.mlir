module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_sum_one_input(%arg0: tensor<3xf32>) -> tensor<3xf32> {
    return %arg0 : tensor<3xf32>
  }
}

