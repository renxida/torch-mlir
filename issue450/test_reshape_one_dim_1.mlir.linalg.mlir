module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reshape_one_dim(%arg0: tensor<2x3x4xf32>, %arg1: tensor<1xi64>) -> tensor<24xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0, 1, 2]] : tensor<2x3x4xf32> into tensor<24xf32>
    return %collapsed : tensor<24xf32>
  }
}

