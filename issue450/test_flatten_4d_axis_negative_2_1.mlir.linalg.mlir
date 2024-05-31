module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_flatten_4d_axis_negative_2(%arg0: tensor<2x3x4x5xf32>) -> tensor<6x20xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0, 1], [2, 3]] : tensor<2x3x4x5xf32> into tensor<6x20xf32>
    return %collapsed : tensor<6x20xf32>
  }
}

