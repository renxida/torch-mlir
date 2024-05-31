#map = affine_map<() -> ()>
#map1 = affine_map<(d0, d1, d2) -> ()>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_reduce_min_empty_set_fp(%arg0: tensor<2x0x4xf32>, %arg1: tensor<1xi64>) -> tensor<2x1x4xf32> {
    %cst = arith.constant dense<0x7FF0000000000000> : tensor<f64>
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%cst : tensor<f64>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %4 = arith.truncf %in : f64 to f32
      linalg.yield %4 : f32
    } -> tensor<f32>
    %2 = tensor.empty() : tensor<2x1x4xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%1 : tensor<f32>) outs(%2 : tensor<2x1x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<2x1x4xf32>
    return %3 : tensor<2x1x4xf32>
  }
}

