module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_conv_with_strides_padding(%arg0: tensor<1x1x7x5xf32>, %arg1: tensor<1x1x3x3xf32>) -> tensor<1x1x4x3xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %padded = tensor.pad %arg0 low[0, 0, 1, 1] high[0, 0, 1, 1] {
    ^bb0(%arg2: index, %arg3: index, %arg4: index, %arg5: index):
      tensor.yield %cst : f32
    } : tensor<1x1x7x5xf32> to tensor<1x1x9x7xf32>
    %0 = tensor.empty() : tensor<1x1x4x3xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x1x4x3xf32>) -> tensor<1x1x4x3xf32>
    %2 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%padded, %arg1 : tensor<1x1x9x7xf32>, tensor<1x1x3x3xf32>) outs(%1 : tensor<1x1x4x3xf32>) -> tensor<1x1x4x3xf32>
    return %2 : tensor<1x1x4x3xf32>
  }
}

