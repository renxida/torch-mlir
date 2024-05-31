#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_gemm_alpha_beta(%arg0: tensor<3x5xf32>, %arg1: tensor<5x4xf32>, %arg2: tensor<1x4xf32>) -> tensor<3x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %cst_1 = arith.constant 2.500000e-01 : f32
    %0 = tensor.empty() : tensor<3x4xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3x4xf32>) -> tensor<3x4xf32>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<3x5xf32>, tensor<5x4xf32>) outs(%1 : tensor<3x4xf32>) -> tensor<3x4xf32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<3x4xf32>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %5 = arith.mulf %in, %cst_0 : f32
      linalg.yield %5 : f32
    } -> tensor<3x4xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map1, #map], iterator_types = ["parallel", "parallel"]} ins(%3, %arg2 : tensor<3x4xf32>, tensor<1x4xf32>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_2: f32, %out: f32):
      %5 = arith.mulf %in_2, %cst_1 : f32
      %6 = arith.addf %in, %5 : f32
      linalg.yield %6 : f32
    } -> tensor<3x4xf32>
    return %4 : tensor<3x4xf32>
  }
}

