module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_flatten_1d_axis_0(%arg0: tensor<2xf32>) -> tensor<1x2xf32> {
    %expanded = tensor.expand_shape %arg0 [[0, 1]] output_shape [1, 2] : tensor<2xf32> into tensor<1x2xf32>
    return %expanded : tensor<1x2xf32>
  }
}

