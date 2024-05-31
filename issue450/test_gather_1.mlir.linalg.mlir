#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map1 = affine_map<(d0, d1, d2) -> (d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_gather(%arg0: tensor<3x4x5xf32>, %arg1: tensor<8x10x20x40xi64>) -> tensor<8x10x20x40x4x5xf32> {
    %c3_i64 = arith.constant 3 : i64
    %c0_i64 = arith.constant 0 : i64
    %0 = tensor.empty() : tensor<8x10x20x40xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg1 : tensor<8x10x20x40xi64>) outs(%0 : tensor<8x10x20x40xi1>) {
    ^bb0(%in: i64, %out: i1):
      %7 = arith.cmpi slt, %in, %c0_i64 : i64
      linalg.yield %7 : i1
    } -> tensor<8x10x20x40xi1>
    %2 = tensor.empty() : tensor<8x10x20x40xi64>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg1 : tensor<8x10x20x40xi64>) outs(%2 : tensor<8x10x20x40xi64>) {
    ^bb0(%in: i64, %out: i64):
      %7 = arith.addi %in, %c3_i64 : i64
      linalg.yield %7 : i64
    } -> tensor<8x10x20x40xi64>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%1, %3, %arg1 : tensor<8x10x20x40xi1>, tensor<8x10x20x40xi64>, tensor<8x10x20x40xi64>) outs(%2 : tensor<8x10x20x40xi64>) {
    ^bb0(%in: i1, %in_0: i64, %in_1: i64, %out: i64):
      %7 = arith.select %in, %in_0, %in_1 : i64
      linalg.yield %7 : i64
    } -> tensor<8x10x20x40xi64>
    %collapsed = tensor.collapse_shape %4 [[0, 1, 2, 3]] : tensor<8x10x20x40xi64> into tensor<64000xi64>
    %5 = tensor.empty() : tensor<64000x4x5xf32>
    %6 = linalg.generic {indexing_maps = [#map1, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<64000xi64>) outs(%5 : tensor<64000x4x5xf32>) {
    ^bb0(%in: i64, %out: f32):
      %7 = arith.index_cast %in : i64 to index
      %8 = linalg.index 1 : index
      %9 = linalg.index 2 : index
      %extracted = tensor.extract %arg0[%7, %8, %9] : tensor<3x4x5xf32>
      linalg.yield %extracted : f32
    } -> tensor<64000x4x5xf32>
    %expanded = tensor.expand_shape %6 [[0, 1, 2, 3], [4], [5]] output_shape [8, 10, 20, 40, 4, 5] : tensor<64000x4x5xf32> into tensor<8x10x20x40x4x5xf32>
    return %expanded : tensor<8x10x20x40x4x5xf32>
  }
}

