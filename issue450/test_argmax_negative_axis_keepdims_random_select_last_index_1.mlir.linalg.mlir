#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_argmax_negative_axis_keepdims_random_select_last_index(%arg0: tensor<2x3x4xf32>) -> tensor<2x3x1xi64> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0_i64 = arith.constant 0 : i64
    %cst_0 = arith.constant 0xFF800000 : f32
    %c3_i64 = arith.constant 3 : i64
    %c3 = arith.constant 3 : index
    %0 = tensor.empty() : tensor<2x3x4xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<2x3x4xf32>) -> tensor<2x3x4xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<2x3x4xf32>) outs(%1 : tensor<2x3x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      %11 = linalg.index 0 : index
      %12 = linalg.index 1 : index
      %13 = linalg.index 2 : index
      %14 = arith.subi %c3, %13 : index
      %extracted = tensor.extract %arg0[%11, %12, %14] : tensor<2x3x4xf32>
      linalg.yield %extracted : f32
    } -> tensor<2x3x4xf32>
    %3 = tensor.empty() : tensor<2x3xi64>
    %4 = linalg.fill ins(%c0_i64 : i64) outs(%3 : tensor<2x3xi64>) -> tensor<2x3xi64>
    %5 = tensor.empty() : tensor<2x3xf32>
    %6 = linalg.fill ins(%cst_0 : f32) outs(%5 : tensor<2x3xf32>) -> tensor<2x3xf32>
    %7:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%2 : tensor<2x3x4xf32>) outs(%6, %4 : tensor<2x3xf32>, tensor<2x3xi64>) {
    ^bb0(%in: f32, %out: f32, %out_1: i64):
      %11 = linalg.index 2 : index
      %12 = arith.index_cast %11 : index to i64
      %13 = arith.maximumf %in, %out : f32
      %14 = arith.cmpf ogt, %in, %out : f32
      %15 = arith.select %14, %12, %out_1 : i64
      linalg.yield %13, %15 : f32, i64
    } -> (tensor<2x3xf32>, tensor<2x3xi64>)
    %expanded = tensor.expand_shape %7#1 [[0], [1, 2]] output_shape [2, 3, 1] : tensor<2x3xi64> into tensor<2x3x1xi64>
    %8 = tensor.empty() : tensor<2x3x1xi64>
    %9 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%expanded : tensor<2x3x1xi64>) outs(%8 : tensor<2x3x1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %11 = arith.subi %in, %c3_i64 : i64
      linalg.yield %11 : i64
    } -> tensor<2x3x1xi64>
    %10 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x3x1xi64>) outs(%8 : tensor<2x3x1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %11 = math.absi %in : i64
      linalg.yield %11 : i64
    } -> tensor<2x3x1xi64>
    return %10 : tensor<2x3x1xi64>
  }
}

