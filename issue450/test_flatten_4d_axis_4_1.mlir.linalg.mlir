module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_flatten_4d_axis_4(%arg0: tensor<2x3x4x5xf32>) -> tensor<120x1xf32> {
    %expanded = tensor.expand_shape %arg0 [[0], [1], [2], [3, 4]] output_shape [2, 3, 4, 5, 1] : tensor<2x3x4x5xf32> into tensor<2x3x4x5x1xf32>
    %collapsed = tensor.collapse_shape %expanded [[0, 1, 2, 3], [4]] : tensor<2x3x4x5x1xf32> into tensor<120x1xf32>
    return %collapsed : tensor<120x1xf32>
  }
}

