#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<() -> ()>
#map5 = affine_map<(d0, d1) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_onehot_negative_indices(%arg0: tensor<3xi64>, %arg1: tensor<f32>, %arg2: tensor<2xf32>) -> tensor<3x10xf32> {
    %c0_i64 = arith.constant 0 : i64
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg1[] : tensor<f32>
    %0 = arith.extf %extracted : f32 to f64
    %1 = arith.fptosi %0 : f64 to i64
    %2 = tensor.empty() : tensor<3xi1>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<3xi64>) outs(%2 : tensor<3xi1>) {
    ^bb0(%in: i64, %out: i1):
      %25 = arith.cmpi slt, %in, %c0_i64 : i64
      linalg.yield %25 : i1
    } -> tensor<3xi1>
    %4 = tensor.empty() : tensor<3xi64>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<3xi64>) outs(%4 : tensor<3xi64>) {
    ^bb0(%in: i64, %out: i64):
      %25 = arith.addi %in, %1 : i64
      linalg.yield %25 : i64
    } -> tensor<3xi64>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel"]} ins(%3, %5, %arg0 : tensor<3xi1>, tensor<3xi64>, tensor<3xi64>) outs(%4 : tensor<3xi64>) {
    ^bb0(%in: i1, %in_3: i64, %in_4: i64, %out: i64):
      %25 = arith.select %in, %in_3, %in_4 : i64
      linalg.yield %25 : i64
    } -> tensor<3xi64>
    %extracted_slice = tensor.extract_slice %arg2[0] [1] [1] : tensor<2xf32> to tensor<1xf32>
    %extracted_0 = tensor.extract %extracted_slice[%c0] : tensor<1xf32>
    %7 = arith.extf %extracted_0 : f32 to f64
    %extracted_slice_1 = tensor.extract_slice %arg2[1] [1] [1] : tensor<2xf32> to tensor<1xf32>
    %extracted_2 = tensor.extract %extracted_slice_1[%c0] : tensor<1xf32>
    %8 = arith.extf %extracted_2 : f32 to f64
    %9 = arith.index_cast %1 : i64 to index
    %10 = tensor.empty(%9) : tensor<?xi64>
    %11 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%10 : tensor<?xi64>) {
    ^bb0(%out: i64):
      %25 = linalg.index 0 : index
      %26 = arith.index_cast %25 : index to i64
      linalg.yield %26 : i64
    } -> tensor<?xi64>
    %expanded = tensor.expand_shape %6 [[0, 1]] output_shape [3, 1] : tensor<3xi64> into tensor<3x1xi64>
    %12 = tensor.empty() : tensor<3x10xi1>
    %13 = linalg.generic {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel"]} ins(%expanded, %11 : tensor<3x1xi64>, tensor<?xi64>) outs(%12 : tensor<3x10xi1>) {
    ^bb0(%in: i64, %in_3: i64, %out: i1):
      %25 = arith.cmpi eq, %in, %in_3 : i64
      linalg.yield %25 : i1
    } -> tensor<3x10xi1>
    %14 = tensor.empty() : tensor<3x10xi64>
    %15 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel"]} ins(%13 : tensor<3x10xi1>) outs(%14 : tensor<3x10xi64>) {
    ^bb0(%in: i1, %out: i64):
      %25 = arith.extui %in : i1 to i64
      linalg.yield %25 : i64
    } -> tensor<3x10xi64>
    %16 = linalg.generic {indexing_maps = [#map3, #map3], iterator_types = ["parallel", "parallel"]} ins(%15 : tensor<3x10xi64>) outs(%12 : tensor<3x10xi1>) {
    ^bb0(%in: i64, %out: i1):
      %25 = arith.cmpi ne, %in, %c0_i64 : i64
      linalg.yield %25 : i1
    } -> tensor<3x10xi1>
    %17 = tensor.empty() : tensor<f64>
    %18 = linalg.fill ins(%8 : f64) outs(%17 : tensor<f64>) -> tensor<f64>
    %19 = tensor.empty() : tensor<f32>
    %20 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%18 : tensor<f64>) outs(%19 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %25 = arith.truncf %in : f64 to f32
      linalg.yield %25 : f32
    } -> tensor<f32>
    %21 = linalg.fill ins(%7 : f64) outs(%17 : tensor<f64>) -> tensor<f64>
    %22 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%21 : tensor<f64>) outs(%19 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %25 = arith.truncf %in : f64 to f32
      linalg.yield %25 : f32
    } -> tensor<f32>
    %23 = tensor.empty() : tensor<3x10xf32>
    %24 = linalg.generic {indexing_maps = [#map3, #map5, #map5, #map3], iterator_types = ["parallel", "parallel"]} ins(%16, %20, %22 : tensor<3x10xi1>, tensor<f32>, tensor<f32>) outs(%23 : tensor<3x10xf32>) {
    ^bb0(%in: i1, %in_3: f32, %in_4: f32, %out: f32):
      %25 = arith.select %in, %in_3, %in_4 : f32
      linalg.yield %25 : f32
    } -> tensor<3x10xf32>
    return %24 : tensor<3x10xf32>
  }
}

