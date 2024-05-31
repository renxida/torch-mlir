#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_convtranspose_dilations(%arg0: tensor<1x1x3x3xf32>, %arg1: tensor<1x1x2x2xf32>) -> tensor<1x1x5x5xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %0 = tensor.empty() : tensor<1x1x2x2xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x1x2x2xf32>) -> tensor<1x1x2x2xf32>
    %2 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%1 : tensor<1x1x2x2xf32>) {
    ^bb0(%out: f32):
      %8 = linalg.index 0 : index
      %9 = linalg.index 1 : index
      %10 = linalg.index 2 : index
      %11 = linalg.index 3 : index
      %12 = arith.subi %c1, %10 : index
      %13 = arith.subi %c1, %11 : index
      %extracted = tensor.extract %arg1[%9, %8, %12, %13] : tensor<1x1x2x2xf32>
      linalg.yield %extracted : f32
    } -> tensor<1x1x2x2xf32>
    %3 = tensor.empty() : tensor<1x1x7x7xf32>
    %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<1x1x7x7xf32>) -> tensor<1x1x7x7xf32>
    %inserted_slice = tensor.insert_slice %arg0 into %4[0, 0, 2, 2] [1, 1, 3, 3] [1, 1, 1, 1] : tensor<1x1x3x3xf32> into tensor<1x1x7x7xf32>
    %5 = tensor.empty() : tensor<1x1x5x5xf32>
    %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<1x1x5x5xf32>) -> tensor<1x1x5x5xf32>
    %7 = linalg.conv_2d_nchw_fchw {dilations = dense<2> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%inserted_slice, %2 : tensor<1x1x7x7xf32>, tensor<1x1x2x2xf32>) outs(%6 : tensor<1x1x5x5xf32>) -> tensor<1x1x5x5xf32>
    return %7 : tensor<1x1x5x5xf32>
  }
}

