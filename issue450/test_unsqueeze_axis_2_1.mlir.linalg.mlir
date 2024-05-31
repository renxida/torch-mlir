module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_unsqueeze_axis_2(%arg0: tensor<3x4x5xf32>, %arg1: tensor<1xi64>) -> tensor<3x4x1x5xf32> {
    %expanded = tensor.expand_shape %arg0 [[0], [1], [2, 3]] output_shape [3, 4, 1, 5] : tensor<3x4x5xf32> into tensor<3x4x1x5xf32>
    return %expanded : tensor<3x4x1x5xf32>
  }
}

