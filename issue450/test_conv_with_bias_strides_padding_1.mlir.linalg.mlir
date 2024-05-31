#map = affine_map<(d0, d1, d2, d3) -> (d1)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_conv_with_bias_strides_padding(%arg0: tensor<?x?x224x224xf32>, %arg1: tensor<64x3x7x7xf32>, %arg2: tensor<64xf32>) -> tensor<?x64x112x112xf32> {
    %c0 = arith.constant 0 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?x224x224xf32>
    %padded = tensor.pad %arg0 low[0, 0, 3, 3] high[0, 0, 3, 3] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index):
      tensor.yield %cst : f32
    } : tensor<?x?x224x224xf32> to tensor<?x?x230x230xf32>
    %0 = tensor.empty(%dim) : tensor<?x64x112x112xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg2 : tensor<64xf32>) outs(%0 : tensor<?x64x112x112xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x64x112x112xf32>
    %2 = linalg.conv_2d_nchw_fchw {dilations = dense<1> : vector<2xi64>, strides = dense<2> : vector<2xi64>} ins(%padded, %arg1 : tensor<?x?x230x230xf32>, tensor<64x3x7x7xf32>) outs(%1 : tensor<?x64x112x112xf32>) -> tensor<?x64x112x112xf32>
    return %2 : tensor<?x64x112x112xf32>
  }
}

