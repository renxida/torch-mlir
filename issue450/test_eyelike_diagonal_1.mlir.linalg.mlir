#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<() -> ()>
#map5 = affine_map<(d0, d1) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_eyelike_diagonal(%arg0: tensor<3x4xf32>) -> tensor<3x4xf32> {
    %cst = arith.constant dense<0.000000e+00> : tensor<f64>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %cst_1 = arith.constant dense<1.000000e+00> : tensor<f64>
    %0 = tensor.empty() : tensor<3xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<3xi64>) {
    ^bb0(%out: i64):
      %11 = linalg.index 0 : index
      %12 = arith.index_cast %11 : index to i64
      linalg.yield %12 : i64
    } -> tensor<3xi64>
    %expanded = tensor.expand_shape %1 [[0, 1]] output_shape [3, 1] : tensor<3xi64> into tensor<3x1xi64>
    %2 = tensor.empty() : tensor<3x3xi1>
    %3 = linalg.generic {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel"]} ins(%expanded, %1 : tensor<3x1xi64>, tensor<3xi64>) outs(%2 : tensor<3x3xi1>) {
    ^bb0(%in: i64, %in_2: i64, %out: i1):
      %11 = arith.cmpi eq, %in, %in_2 : i64
      linalg.yield %11 : i1
    } -> tensor<3x3xi1>
    %4 = tensor.empty() : tensor<f32>
    %5 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst_1 : tensor<f64>) outs(%4 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %11 = arith.truncf %in : f64 to f32
      linalg.yield %11 : f32
    } -> tensor<f32>
    %6 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst : tensor<f64>) outs(%4 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %11 = arith.truncf %in : f64 to f32
      linalg.yield %11 : f32
    } -> tensor<f32>
    %7 = tensor.empty() : tensor<3x3xf32>
    %8 = linalg.generic {indexing_maps = [#map3, #map5, #map5, #map3], iterator_types = ["parallel", "parallel"]} ins(%3, %5, %6 : tensor<3x3xi1>, tensor<f32>, tensor<f32>) outs(%7 : tensor<3x3xf32>) {
    ^bb0(%in: i1, %in_2: f32, %in_3: f32, %out: f32):
      %11 = arith.select %in, %in_2, %in_3 : f32
      linalg.yield %11 : f32
    } -> tensor<3x3xf32>
    %9 = tensor.empty() : tensor<3x4xf32>
    %10 = linalg.fill ins(%cst_0 : f32) outs(%9 : tensor<3x4xf32>) -> tensor<3x4xf32>
    %inserted_slice = tensor.insert_slice %8 into %10[0, 1] [3, 3] [1, 1] : tensor<3x3xf32> into tensor<3x4xf32>
    return %inserted_slice : tensor<3x4xf32>
  }
}

