#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_clip_attrs(%arg0: tensor<3x4xf32>) -> tensor<3x4xf32> {
    %cst = arith.constant dense<5.000000e-01> : tensor<3x4xf32>
    %cst_0 = arith.constant dense<-5.000000e-01> : tensor<3x4xf32>
    %0 = tensor.empty() : tensor<3x4xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %cst_0, %cst : tensor<3x4xf32>, tensor<3x4xf32>, tensor<3x4xf32>) outs(%0 : tensor<3x4xf32>) {
    ^bb0(%in: f32, %in_1: f32, %in_2: f32, %out: f32):
      %2 = arith.cmpf ult, %in, %in_1 : f32
      %3 = arith.select %2, %in_1, %in : f32
      %4 = arith.cmpf ugt, %3, %in_2 : f32
      %5 = arith.select %4, %in_2, %3 : f32
      linalg.yield %5 : f32
    } -> tensor<3x4xf32>
    return %1 : tensor<3x4xf32>
  }
}

