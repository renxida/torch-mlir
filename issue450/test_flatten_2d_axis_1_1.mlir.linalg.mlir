module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_flatten_2d_axis_1(%arg0: tensor<2x3xf32>) -> tensor<2x3xf32> {
    return %arg0 : tensor<2x3xf32>
  }
}

