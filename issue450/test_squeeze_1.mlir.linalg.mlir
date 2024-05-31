module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_squeeze(%arg0: tensor<1x3x4x5xf32>, %arg1: tensor<1xi64>) -> tensor<3x4x5xf32> {
    %collapsed = tensor.collapse_shape %arg0 [[0, 1], [2], [3]] : tensor<1x3x4x5xf32> into tensor<3x4x5xf32>
    return %collapsed : tensor<3x4x5xf32>
  }
}

