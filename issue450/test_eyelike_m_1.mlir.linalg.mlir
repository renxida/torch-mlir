#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<() -> ()>
#map5 = affine_map<(d0, d1) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_eyelike_m(%arg0: tensor<3x4xf32>) -> tensor<3x4xf32> {
    %cst = arith.constant dense<0.000000e+00> : tensor<f64>
    %cst_0 = arith.constant dense<1.000000e+00> : tensor<f64>
    %0 = tensor.empty() : tensor<3xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<3xi64>) {
    ^bb0(%out: i64):
      %11 = linalg.index 0 : index
      %12 = arith.index_cast %11 : index to i64
      linalg.yield %12 : i64
    } -> tensor<3xi64>
    %2 = tensor.empty() : tensor<4xi64>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<4xi64>) {
    ^bb0(%out: i64):
      %11 = linalg.index 0 : index
      %12 = arith.index_cast %11 : index to i64
      linalg.yield %12 : i64
    } -> tensor<4xi64>
    %expanded = tensor.expand_shape %1 [[0, 1]] output_shape [3, 1] : tensor<3xi64> into tensor<3x1xi64>
    %4 = tensor.empty() : tensor<3x4xi1>
    %5 = linalg.generic {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel"]} ins(%expanded, %3 : tensor<3x1xi64>, tensor<4xi64>) outs(%4 : tensor<3x4xi1>) {
    ^bb0(%in: i64, %in_1: i64, %out: i1):
      %11 = arith.cmpi eq, %in, %in_1 : i64
      linalg.yield %11 : i1
    } -> tensor<3x4xi1>
    %6 = tensor.empty() : tensor<f32>
    %7 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst_0 : tensor<f64>) outs(%6 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %11 = arith.truncf %in : f64 to f32
      linalg.yield %11 : f32
    } -> tensor<f32>
    %8 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst : tensor<f64>) outs(%6 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %11 = arith.truncf %in : f64 to f32
      linalg.yield %11 : f32
    } -> tensor<f32>
    %9 = tensor.empty() : tensor<3x4xf32>
    %10 = linalg.generic {indexing_maps = [#map3, #map5, #map5, #map3], iterator_types = ["parallel", "parallel"]} ins(%5, %7, %8 : tensor<3x4xi1>, tensor<f32>, tensor<f32>) outs(%9 : tensor<3x4xf32>) {
    ^bb0(%in: i1, %in_1: f32, %in_2: f32, %out: f32):
      %11 = arith.select %in, %in_1, %in_2 : f32
      linalg.yield %11 : f32
    } -> tensor<3x4xf32>
    return %10 : tensor<3x4xf32>
  }
}

