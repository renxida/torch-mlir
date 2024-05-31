module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reshape_negative_dim(%arg0: tensor<2x3x4xf32>, %arg1: tensor<3xi64>) -> tensor<2x6x2xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2]] : tensor<2x3x4xf32> into tensor<2x12xf32>
    %expanded = tensor.expand_shape %collapsed [[0], [1, 2]] output_shape [2, 6, 2] : tensor<2x12xf32> into tensor<2x6x2xf32>
    return %expanded : tensor<2x6x2xf32>
  }
}

