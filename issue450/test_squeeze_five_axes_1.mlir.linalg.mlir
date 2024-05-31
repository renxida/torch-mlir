module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_squeeze_five_axes(%arg0: tensor<1x3x1x4x1x5x1x1xf32>, %arg1: tensor<4xi64>) -> tensor<3x1x4x5xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0, 1], [2], [3, 4], [5, 6, 7]] : tensor<1x3x1x4x1x5x1x1xf32> into tensor<3x1x4x5xf32>
    return %collapsed : tensor<3x1x4x5xf32>
  }
}

