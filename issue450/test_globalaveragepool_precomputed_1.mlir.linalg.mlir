#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_globalaveragepool_precomputed(%arg0: tensor<1x1x3x3xf32>) -> tensor<1x1x1x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 9.000000e+00 : f32
    %0 = tensor.empty() : tensor<1x1x1x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %2 = tensor.empty() : tensor<3x3xf32>
    %3 = linalg.pooling_nchw_sum {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%arg0, %2 : tensor<1x1x3x3xf32>, tensor<3x3xf32>) outs(%1 : tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%3 : tensor<1x1x1x1xf32>) outs(%0 : tensor<1x1x1x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %5 = arith.divf %in, %cst_0 : f32
      linalg.yield %5 : f32
    } -> tensor<1x1x1x1xf32>
    return %4 : tensor<1x1x1x1xf32>
  }
}

