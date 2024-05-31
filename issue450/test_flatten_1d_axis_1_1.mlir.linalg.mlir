module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_flatten_1d_axis_1(%arg0: tensor<2xf32>) -> tensor<2x1xf32> {
    %expanded = tensor.expand_shape %arg0 [[0, 1]] output_shape [2, 1] : tensor<2xf32> into tensor<2x1xf32>
    return %expanded : tensor<2x1xf32>
  }
}

