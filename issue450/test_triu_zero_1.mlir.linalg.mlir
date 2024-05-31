#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d0, d1)>
#map3 = affine_map<(d0, d1) -> (0, d1)>
#map4 = affine_map<(d0, d1) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_triu_zero(%arg0: tensor<0x5xi64>, %arg1: tensor<i64>) -> tensor<0x5xi64> {
    %cst = arith.constant dense<0> : tensor<i64>
    %extracted = tensor.extract %arg1[] : tensor<i64>
    %0 = tensor.empty() : tensor<0xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<0xi64>) {
    ^bb0(%out: i64):
      %10 = linalg.index 0 : index
      %11 = arith.index_cast %10 : index to i64
      linalg.yield %11 : i64
    } -> tensor<0xi64>
    %2 = tensor.empty() : tensor<5xi64>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<5xi64>) {
    ^bb0(%out: i64):
      %10 = linalg.index 0 : index
      %11 = arith.index_cast %10 : index to i64
      linalg.yield %11 : i64
    } -> tensor<5xi64>
    %expanded = tensor.expand_shape %1 [[0, 1]] output_shape [0, 1] : tensor<0xi64> into tensor<0x1xi64>
    %expanded_0 = tensor.expand_shape %3 [[0, 1]] output_shape [1, 5] : tensor<5xi64> into tensor<1x5xi64>
    %4 = tensor.empty() : tensor<0x1xi64>
    %5 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%expanded : tensor<0x1xi64>) outs(%4 : tensor<0x1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %10 = arith.addi %in, %extracted : i64
      linalg.yield %10 : i64
    } -> tensor<0x1xi64>
    %6 = tensor.empty() : tensor<0x5xi1>
    %7 = linalg.generic {indexing_maps = [#map3, #map1, #map2], iterator_types = ["parallel", "parallel"]} ins(%expanded_0, %5 : tensor<1x5xi64>, tensor<0x1xi64>) outs(%6 : tensor<0x5xi1>) {
    ^bb0(%in: i64, %in_1: i64, %out: i1):
      %10 = arith.cmpi sge, %in, %in_1 : i64
      linalg.yield %10 : i1
    } -> tensor<0x5xi1>
    %8 = tensor.empty() : tensor<0x5xi64>
    %9 = linalg.generic {indexing_maps = [#map2, #map2, #map4, #map2], iterator_types = ["parallel", "parallel"]} ins(%7, %arg0, %cst : tensor<0x5xi1>, tensor<0x5xi64>, tensor<i64>) outs(%8 : tensor<0x5xi64>) {
    ^bb0(%in: i1, %in_1: i64, %in_2: i64, %out: i64):
      %10 = arith.select %in, %in_1, %in_2 : i64
      linalg.yield %10 : i64
    } -> tensor<0x5xi64>
    return %9 : tensor<0x5xi64>
  }
}

