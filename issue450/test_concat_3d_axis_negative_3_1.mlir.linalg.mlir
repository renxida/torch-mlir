module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_concat_3d_axis_negative_3(%arg0: tensor<2x2x2xf32>, %arg1: tensor<2x2x2xf32>) -> tensor<4x2x2xf32> {
    %concat = tensor.concat dim(0) %arg0, %arg1 : (tensor<2x2x2xf32>, tensor<2x2x2xf32>) -> tensor<4x2x2xf32>
    return %concat : tensor<4x2x2xf32>
  }
}

