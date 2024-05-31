#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_sum_empty_set_non_reduced_axis_zero(%arg0: tensor<2x0x4xf32>, %arg1: tensor<1xi64>) -> tensor<2x0x1xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<2x0x1xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x0x1xf32>) -> tensor<2x0x1xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0 : tensor<2x0x4xf32>) outs(%1 : tensor<2x0x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.addf %in, %out : f32
      linalg.yield %3 : f32
    } -> tensor<2x0x1xf32>
    return %2 : tensor<2x0x1xf32>
  }
}

