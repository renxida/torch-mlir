#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_batchnorm_example(%arg0: tensor<2x3x4x5xf32>, %arg1: tensor<3xf32>, %arg2: tensor<3xf32>, %arg3: tensor<3xf32>, %arg4: tensor<3xf32>) -> tensor<2x3x4x5xf32> {
    %cst = arith.constant 9.99999974E-6 : f32
    %0 = linalg.generic {indexing_maps = [#map, #map1, #map1, #map1, #map1, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0, %arg1, %arg2, %arg3, %arg4 : tensor<2x3x4x5xf32>, tensor<3xf32>, tensor<3xf32>, tensor<3xf32>, tensor<3xf32>) outs(%arg0 : tensor<2x3x4x5xf32>) {
    ^bb0(%in: f32, %in_0: f32, %in_1: f32, %in_2: f32, %in_3: f32, %out: f32):
      %1 = arith.addf %in_3, %cst : f32
      %2 = math.rsqrt %1 : f32
      %3 = arith.subf %in, %in_2 : f32
      %4 = arith.mulf %3, %2 : f32
      %5 = arith.mulf %4, %in_0 : f32
      %6 = arith.addf %5, %in_1 : f32
      linalg.yield %6 : f32
    } -> tensor<2x3x4x5xf32>
    return %0 : tensor<2x3x4x5xf32>
  }
}

