module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reshape_zero_and_negative_dim(%arg0: tensor<2x3x4xf32>, %arg1: tensor<4xi64>) -> tensor<2x3x1x4xf32> {
    %expanded = tensor.expand_shape %arg0 [[0], [1], [2, 3]] output_shape [2, 3, 1, 4] : tensor<2x3x4xf32> into tensor<2x3x1x4xf32>
    return %expanded : tensor<2x3x1x4xf32>
  }
}

