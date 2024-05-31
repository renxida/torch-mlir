module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reshape_reduced_dims(%arg0: tensor<2x3x4xf32>, %arg1: tensor<2xi64>) -> tensor<2x12xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0], [1, 2]] : tensor<2x3x4xf32> into tensor<2x12xf32>
    return %collapsed : tensor<2x12xf32>
  }
}

