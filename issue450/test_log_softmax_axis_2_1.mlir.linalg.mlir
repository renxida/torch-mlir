#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_log_softmax_axis_2(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0xFF800000 : f32
    %cst_0 = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x4xi64>
    %1 = linalg.fill ins(%c0_i64 : i64) outs(%0 : tensor<3x4xi64>) -> tensor<3x4xi64>
    %2 = tensor.empty() : tensor<3x4xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<3x4xf32>) -> tensor<3x4xf32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%3, %1 : tensor<3x4xf32>, tensor<3x4xi64>) {
    ^bb0(%in: f32, %out: f32, %out_1: i64):
      %13 = linalg.index 2 : index
      %14 = arith.index_cast %13 : index to i64
      %15 = arith.maximumf %in, %out : f32
      %16 = arith.cmpf ogt, %in, %out : f32
      %17 = arith.select %16, %14, %out_1 : i64
      linalg.yield %15, %17 : f32, i64
    } -> (tensor<3x4xf32>, tensor<3x4xi64>)
    %expanded = tensor.expand_shape %4#0 [[0], [1, 2]] output_shape [3, 4, 1] : tensor<3x4xf32> into tensor<3x4x1xf32>
    %5 = tensor.empty() : tensor<3x4x5xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %expanded : tensor<3x4x5xf32>, tensor<3x4x1xf32>) outs(%5 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %13 = arith.subf %in, %in_1 : f32
      linalg.yield %13 : f32
    } -> tensor<3x4x5xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6 : tensor<3x4x5xf32>) outs(%5 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %13 = math.exp %in : f32
      linalg.yield %13 : f32
    } -> tensor<3x4x5xf32>
    %8 = tensor.empty() : tensor<3x4x1xf32>
    %9 = linalg.fill ins(%cst_0 : f32) outs(%8 : tensor<3x4x1xf32>) -> tensor<3x4x1xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%7 : tensor<3x4x5xf32>) outs(%9 : tensor<3x4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %13 = arith.addf %in, %out : f32
      linalg.yield %13 : f32
    } -> tensor<3x4x1xf32>
    %11 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%10 : tensor<3x4x1xf32>) outs(%8 : tensor<3x4x1xf32>) {
    ^bb0(%in: f32, %out: f32):
      %13 = math.log %in : f32
      linalg.yield %13 : f32
    } -> tensor<3x4x1xf32>
    %12 = linalg.generic {indexing_maps = [#map, #map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6, %11 : tensor<3x4x5xf32>, tensor<3x4x1xf32>) outs(%5 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %13 = arith.subf %in, %in_1 : f32
      linalg.yield %13 : f32
    } -> tensor<3x4x5xf32>
    return %12 : tensor<3x4x5xf32>
  }
}

