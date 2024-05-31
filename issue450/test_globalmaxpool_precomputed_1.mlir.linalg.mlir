module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_globalmaxpool_precomputed(%arg0: tensor<1x1x3x3xf32>) -> tensor<1x1x1x1xf32> {
    %cst = arith.constant 0xFF800000 : f32
    %0 = tensor.empty() : tensor<1x1x1x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.pooling_nchw_max {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x1x3x3xf32>, tensor<3x3xf32>) outs(%1 : tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    return %3 : tensor<1x1x1x1xf32>
  }
}

