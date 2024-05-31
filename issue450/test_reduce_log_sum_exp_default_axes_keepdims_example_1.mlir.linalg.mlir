#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (0, 0, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_log_sum_exp_default_axes_keepdims_example(%arg0: tensor<3x2x2xf32>, %arg1: tensor<0xi64>) -> tensor<1x1x1xf32> {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = tensor.empty() : tensor<3x2x2xf64>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x2x2xf32>) outs(%0 : tensor<3x2x2xf64>) {
    ^bb0(%in: f32, %out: f64):
      %9 = arith.extf %in : f32 to f64
      linalg.yield %9 : f64
    } -> tensor<3x2x2xf64>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1 : tensor<3x2x2xf64>) outs(%0 : tensor<3x2x2xf64>) {
    ^bb0(%in: f64, %out: f64):
      %9 = math.exp %in : f64
      linalg.yield %9 : f64
    } -> tensor<3x2x2xf64>
    %3 = tensor.empty() : tensor<1x1x1xf64>
    %4 = linalg.fill ins(%cst : f64) outs(%3 : tensor<1x1x1xf64>) -> tensor<1x1x1xf64>
    %5 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction", "reduction"]} ins(%2 : tensor<3x2x2xf64>) outs(%4 : tensor<1x1x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %9 = arith.addf %in, %out : f64
      linalg.yield %9 : f64
    } -> tensor<1x1x1xf64>
    %6 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5 : tensor<1x1x1xf64>) outs(%3 : tensor<1x1x1xf64>) {
    ^bb0(%in: f64, %out: f64):
      %9 = math.log %in : f64
      linalg.yield %9 : f64
    } -> tensor<1x1x1xf64>
    %7 = tensor.empty() : tensor<1x1x1xf32>
    %8 = linalg.generic {indexing_maps = [#map1, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6 : tensor<1x1x1xf64>) outs(%7 : tensor<1x1x1xf32>) {
    ^bb0(%in: f64, %out: f32):
      %9 = arith.truncf %in : f64 to f32
      linalg.yield %9 : f32
    } -> tensor<1x1x1xf32>
    return %8 : tensor<1x1x1xf32>
  }
}

