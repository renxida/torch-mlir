#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, 0)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
#map3 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_gather_nd(%arg0: tensor<2x6x8x5xf32>, %arg1: tensor<2x4x3x2xi64>) -> tensor<2x4x3x5xf32> {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %c48 = arith.constant 48 : index
    %c6_i64 = arith.constant 6 : i64
    %c8_i64 = arith.constant 8 : i64
    %extracted_slice = tensor.extract_slice %arg1[0, 0, 0, 0] [2, 4, 3, 1] [1, 1, 1, 1] : tensor<2x4x3x2xi64> to tensor<2x4x3x1xi64>
    %0 = tensor.empty() : tensor<2x4x3x1xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<2x4x3x1xi64>) outs(%0 : tensor<2x4x3x1xi1>) {
    ^bb0(%in: i64, %out: i1):
      %14 = arith.cmpi slt, %in, %c0_i64 : i64
      linalg.yield %14 : i1
    } -> tensor<2x4x3x1xi1>
    %2 = tensor.empty() : tensor<2x4x3x1xi64>
    %3 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice : tensor<2x4x3x1xi64>) outs(%2 : tensor<2x4x3x1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %14 = arith.addi %in, %c6_i64 : i64
      linalg.yield %14 : i64
    } -> tensor<2x4x3x1xi64>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%1, %3, %extracted_slice : tensor<2x4x3x1xi1>, tensor<2x4x3x1xi64>, tensor<2x4x3x1xi64>) outs(%2 : tensor<2x4x3x1xi64>) {
    ^bb0(%in: i1, %in_2: i64, %in_3: i64, %out: i64):
      %14 = arith.select %in, %in_2, %in_3 : i64
      linalg.yield %14 : i64
    } -> tensor<2x4x3x1xi64>
    %extracted_slice_0 = tensor.extract_slice %arg1[0, 0, 0, 1] [2, 4, 3, 1] [1, 1, 1, 1] : tensor<2x4x3x2xi64> to tensor<2x4x3x1xi64>
    %5 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_0 : tensor<2x4x3x1xi64>) outs(%0 : tensor<2x4x3x1xi1>) {
    ^bb0(%in: i64, %out: i1):
      %14 = arith.cmpi slt, %in, %c0_i64 : i64
      linalg.yield %14 : i1
    } -> tensor<2x4x3x1xi1>
    %6 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%extracted_slice_0 : tensor<2x4x3x1xi64>) outs(%2 : tensor<2x4x3x1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %14 = arith.addi %in, %c8_i64 : i64
      linalg.yield %14 : i64
    } -> tensor<2x4x3x1xi64>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%5, %6, %extracted_slice_0 : tensor<2x4x3x1xi1>, tensor<2x4x3x1xi64>, tensor<2x4x3x1xi64>) outs(%2 : tensor<2x4x3x1xi64>) {
    ^bb0(%in: i1, %in_2: i64, %in_3: i64, %out: i64):
      %14 = arith.select %in, %in_2, %in_3 : i64
      linalg.yield %14 : i64
    } -> tensor<2x4x3x1xi64>
    %8 = linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%7, %4 : tensor<2x4x3x1xi64>, tensor<2x4x3x1xi64>) outs(%2 : tensor<2x4x3x1xi64>) {
    ^bb0(%in: i64, %in_2: i64, %out: i64):
      %14 = arith.muli %in_2, %c8_i64 : i64
      %15 = arith.addi %in, %14 : i64
      linalg.yield %15 : i64
    } -> tensor<2x4x3x1xi64>
    %collapsed = tensor.collapse_shape %8 [[0], [1, 2], [3]] : tensor<2x4x3x1xi64> into tensor<2x12x1xi64>
    %9 = tensor.empty() : tensor<2x12x5xi64>
    %10 = linalg.generic {indexing_maps = [#map2, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%collapsed : tensor<2x12x1xi64>) outs(%9 : tensor<2x12x5xi64>) {
    ^bb0(%in: i64, %out: i64):
      linalg.yield %in : i64
    } -> tensor<2x12x5xi64>
    %collapsed_1 = tensor.collapse_shape %arg0 [[0], [1, 2], [3]] : tensor<2x6x8x5xf32> into tensor<2x48x5xf32>
    %11 = tensor.empty() : tensor<2x12x5xf32>
    %12 = linalg.fill ins(%cst : f32) outs(%11 : tensor<2x12x5xf32>) -> tensor<2x12x5xf32>
    %13 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel", "parallel"]} ins(%10 : tensor<2x12x5xi64>) outs(%12 : tensor<2x12x5xf32>) {
    ^bb0(%in: i64, %out: f32):
      %14 = linalg.index 0 : index
      %15 = arith.index_cast %in : i64 to index
      %16 = linalg.index 2 : index
      %17 = arith.cmpi slt, %15, %c48 : index
      cf.assert %17, "index must be smaller than dim size"
      %18 = arith.cmpi sge, %in, %c0_i64 : i64
      cf.assert %18, "index must be larger or equal to 0"
      %extracted = tensor.extract %collapsed_1[%14, %15, %16] : tensor<2x48x5xf32>
      linalg.yield %extracted : f32
    } -> tensor<2x12x5xf32>
    %expanded = tensor.expand_shape %13 [[0], [1, 2], [3]] output_shape [2, 4, 3, 5] : tensor<2x12x5xf32> into tensor<2x4x3x5xf32>
    return %expanded : tensor<2x4x3x5xf32>
  }
}

