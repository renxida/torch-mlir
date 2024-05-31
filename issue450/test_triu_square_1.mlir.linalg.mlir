#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
#map4 = affine_map<(d0, d1, d2) -> (d1, d2)>
#map5 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map6 = affine_map<(d0, d1, d2) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_triu_square(%arg0: tensor<2x3x3xi64>) -> tensor<2x3x3xi64> {
    %cst = arith.constant dense<0> : tensor<i64>
    %0 = tensor.empty() : tensor<3xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<3xi64>) {
    ^bb0(%out: i64):
      %8 = linalg.index 0 : index
      %9 = arith.index_cast %8 : index to i64
      linalg.yield %9 : i64
    } -> tensor<3xi64>
    %expanded = tensor.expand_shape %1 [[0, 1]] output_shape [3, 1] : tensor<3xi64> into tensor<3x1xi64>
    %expanded_0 = tensor.expand_shape %1 [[0, 1]] output_shape [1, 3] : tensor<3xi64> into tensor<1x3xi64>
    %2 = tensor.empty() : tensor<3x1xi64>
    %3 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%expanded : tensor<3x1xi64>) outs(%2 : tensor<3x1xi64>) {
    ^bb0(%in: i64, %out: i64):
      linalg.yield %in : i64
    } -> tensor<3x1xi64>
    %4 = tensor.empty() : tensor<3x3xi1>
    %5 = linalg.generic {indexing_maps = [#map3, #map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%expanded_0, %3 : tensor<1x3xi64>, tensor<3x1xi64>) outs(%4 : tensor<3x3xi1>) {
    ^bb0(%in: i64, %in_1: i64, %out: i1):
      %8 = arith.cmpi sge, %in, %in_1 : i64
      linalg.yield %8 : i1
    } -> tensor<3x3xi1>
    %6 = tensor.empty() : tensor<2x3x3xi64>
    %7 = linalg.generic {indexing_maps = [#map4, #map5, #map6, #map5], iterator_types = ["parallel", "parallel", "parallel"]} ins(%5, %arg0, %cst : tensor<3x3xi1>, tensor<2x3x3xi64>, tensor<i64>) outs(%6 : tensor<2x3x3xi64>) {
    ^bb0(%in: i1, %in_1: i64, %in_2: i64, %out: i64):
      %8 = arith.select %in, %in_1, %in_2 : i64
      linalg.yield %8 : i64
    } -> tensor<2x3x3xi64>
    return %7 : tensor<2x3x3xi64>
  }
}

