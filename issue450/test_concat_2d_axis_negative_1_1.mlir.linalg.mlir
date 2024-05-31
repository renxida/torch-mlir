module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_concat_2d_axis_negative_1(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>) -> tensor<2x4xf32> {
    %concat = tensor.concat dim(1) %arg0, %arg1 : (tensor<2x2xf32>, tensor<2x2xf32>) -> tensor<2x4xf32>
    return %concat : tensor<2x4xf32>
  }
}

