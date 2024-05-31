#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_where_example(%arg0: tensor<2x2xi1>, %arg1: tensor<2x2xf32>, %arg2: tensor<2x2xf32>) -> tensor<2x2xf32> {
    %0 = tensor.empty() : tensor<2x2xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1, %arg2 : tensor<2x2xi1>, tensor<2x2xf32>, tensor<2x2xf32>) outs(%0 : tensor<2x2xf32>) {
    ^bb0(%in: i1, %in_0: f32, %in_1: f32, %out: f32):
      %2 = arith.select %in, %in_0, %in_1 : f32
      linalg.yield %2 : f32
    } -> tensor<2x2xf32>
    return %1 : tensor<2x2xf32>
  }
  func.func @test_where_long_example(%arg0: tensor<2x2xi1>, %arg1: tensor<2x2xi64>, %arg2: tensor<2x2xi64>) -> tensor<2x2xi64> {
    %0 = tensor.empty() : tensor<2x2xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1, %arg2 : tensor<2x2xi1>, tensor<2x2xi64>, tensor<2x2xi64>) outs(%0 : tensor<2x2xi64>) {
    ^bb0(%in: i1, %in_0: i64, %in_1: i64, %out: i64):
      %2 = arith.select %in, %in_0, %in_1 : i64
      linalg.yield %2 : i64
    } -> tensor<2x2xi64>
    return %1 : tensor<2x2xi64>
  }
}

