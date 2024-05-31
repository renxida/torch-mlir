#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<() -> ()>
#map5 = affine_map<(d0, d1) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_eyelike_int(%arg0: tensor<3x3xf32>) -> tensor<3x3xi64> {
    %cst = arith.constant dense<0.000000e+00> : tensor<f64>
    %cst_0 = arith.constant dense<1.000000e+00> : tensor<f64>
    %0 = tensor.empty() : tensor<3xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<3xi64>) {
    ^bb0(%out: i64):
      %9 = linalg.index 0 : index
      %10 = arith.index_cast %9 : index to i64
      linalg.yield %10 : i64
    } -> tensor<3xi64>
    %expanded = tensor.expand_shape %1 [[0, 1]] output_shape [3, 1] : tensor<3xi64> into tensor<3x1xi64>
    %2 = tensor.empty() : tensor<3x3xi1>
    %3 = linalg.generic {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel"]} ins(%expanded, %1 : tensor<3x1xi64>, tensor<3xi64>) outs(%2 : tensor<3x3xi1>) {
    ^bb0(%in: i64, %in_1: i64, %out: i1):
      %9 = arith.cmpi eq, %in, %in_1 : i64
      linalg.yield %9 : i1
    } -> tensor<3x3xi1>
    %4 = tensor.empty() : tensor<i64>
    %5 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst_0 : tensor<f64>) outs(%4 : tensor<i64>) {
    ^bb0(%in: f64, %out: i64):
      %9 = arith.fptosi %in : f64 to i64
      linalg.yield %9 : i64
    } -> tensor<i64>
    %6 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst : tensor<f64>) outs(%4 : tensor<i64>) {
    ^bb0(%in: f64, %out: i64):
      %9 = arith.fptosi %in : f64 to i64
      linalg.yield %9 : i64
    } -> tensor<i64>
    %7 = tensor.empty() : tensor<3x3xi64>
    %8 = linalg.generic {indexing_maps = [#map3, #map5, #map5, #map3], iterator_types = ["parallel", "parallel"]} ins(%3, %5, %6 : tensor<3x3xi1>, tensor<i64>, tensor<i64>) outs(%7 : tensor<3x3xi64>) {
    ^bb0(%in: i1, %in_1: i64, %in_2: i64, %out: i64):
      %9 = arith.select %in, %in_1, %in_2 : i64
      linalg.yield %9 : i64
    } -> tensor<3x3xi64>
    return %8 : tensor<3x3xi64>
  }
}

