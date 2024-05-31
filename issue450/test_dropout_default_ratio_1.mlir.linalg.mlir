module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_dropout_default_ratio(%arg0: tensor<3x4x5xf32>, %arg1: tensor<f32>) -> tensor<3x4x5xf32> {
    return %arg0 : tensor<3x4x5xf32>
  }
}

