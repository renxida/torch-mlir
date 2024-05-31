module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_size(%arg0: tensor<3x4x5xf32>) -> tensor<i32> {
    %cst = arith.constant dense<60> : tensor<i32>
    return %cst : tensor<i32>
  }
}

