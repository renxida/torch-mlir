module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_flatten_4d_axis_negative_4(%arg0: tensor<2x3x4x5xf32>) -> tensor<1x120xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2, 3]] : tensor<2x3x4x5xf32> into tensor<120xf32>
    %expanded = tensor.expand_shape %collapsed [[0, 1]] output_shape [1, 120] : tensor<120xf32> into tensor<1x120xf32>
    return %expanded : tensor<1x120xf32>
  }
}

