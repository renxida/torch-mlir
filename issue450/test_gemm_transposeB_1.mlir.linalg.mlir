#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d1, d0)>
#map2 = affine_map<(d0, d1) -> (0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_gemm_transposeB(%arg0: tensor<3x5xf32>, %arg1: tensor<4x5xf32>, %arg2: tensor<1x4xf32>) -> tensor<3x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<5x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<4x5xf32>) outs(%0 : tensor<5x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<5x4xf32>
    %2 = tensor.empty() : tensor<3x4xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<3x4xf32>) -> tensor<3x4xf32>
    %4 = linalg.matmul ins(%arg0, %1 : tensor<3x5xf32>, tensor<5x4xf32>) outs(%3 : tensor<3x4xf32>) -> tensor<3x4xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel"]} ins(%4, %arg2 : tensor<3x4xf32>, tensor<1x4xf32>) outs(%2 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %6 = arith.addf %in, %in_0 : f32
      linalg.yield %6 : f32
    } -> tensor<3x4xf32>
    return %5 : tensor<3x4xf32>
  }
}

