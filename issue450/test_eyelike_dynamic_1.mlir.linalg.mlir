#map = affine_map<(d0) -> (d0)>
#map1 = affine_map<(d0, d1) -> (d0, 0)>
#map2 = affine_map<(d0, d1) -> (d1)>
#map3 = affine_map<(d0, d1) -> (d0, d1)>
#map4 = affine_map<() -> ()>
#map5 = affine_map<(d0, d1) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_eyelike_dynamic(%arg0: tensor<3x?xf32>) -> tensor<3x?xf32> {
    %cst = arith.constant dense<1.000000e+00> : tensor<f64>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %cst_1 = arith.constant dense<0.000000e+00> : tensor<f64>
    %dim = tensor.dim %arg0, %c1 : tensor<3x?xf32>
    %0 = tensor.empty() : tensor<2xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<2xi64>) {
    ^bb0(%out: i64):
      %13 = linalg.index 0 : index
      %14 = arith.index_cast %13 : index to i64
      linalg.yield %14 : i64
    } -> tensor<2xi64>
    %2 = tensor.empty(%dim) : tensor<?xi64>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<?xi64>) {
    ^bb0(%out: i64):
      %13 = linalg.index 0 : index
      %14 = arith.index_cast %13 : index to i64
      linalg.yield %14 : i64
    } -> tensor<?xi64>
    %expanded = tensor.expand_shape %1 [[0, 1]] output_shape [2, 1] : tensor<2xi64> into tensor<2x1xi64>
    %4 = tensor.empty(%dim) : tensor<2x?xi1>
    %5 = linalg.generic {indexing_maps = [#map1, #map2, #map3], iterator_types = ["parallel", "parallel"]} ins(%expanded, %3 : tensor<2x1xi64>, tensor<?xi64>) outs(%4 : tensor<2x?xi1>) {
    ^bb0(%in: i64, %in_2: i64, %out: i1):
      %13 = arith.cmpi eq, %in, %in_2 : i64
      linalg.yield %13 : i1
    } -> tensor<2x?xi1>
    %6 = tensor.empty() : tensor<f32>
    %7 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst : tensor<f64>) outs(%6 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %13 = arith.truncf %in : f64 to f32
      linalg.yield %13 : f32
    } -> tensor<f32>
    %8 = linalg.generic {indexing_maps = [#map4, #map4], iterator_types = []} ins(%cst_1 : tensor<f64>) outs(%6 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %13 = arith.truncf %in : f64 to f32
      linalg.yield %13 : f32
    } -> tensor<f32>
    %9 = tensor.empty(%dim) : tensor<2x?xf32>
    %10 = linalg.generic {indexing_maps = [#map3, #map5, #map5, #map3], iterator_types = ["parallel", "parallel"]} ins(%5, %7, %8 : tensor<2x?xi1>, tensor<f32>, tensor<f32>) outs(%9 : tensor<2x?xf32>) {
    ^bb0(%in: i1, %in_2: f32, %in_3: f32, %out: f32):
      %13 = arith.select %in, %in_2, %in_3 : f32
      linalg.yield %13 : f32
    } -> tensor<2x?xf32>
    %11 = tensor.empty(%dim) : tensor<3x?xf32>
    %12 = linalg.fill ins(%cst_0 : f32) outs(%11 : tensor<3x?xf32>) -> tensor<3x?xf32>
    %inserted_slice = tensor.insert_slice %10 into %12[1, 0] [2, %dim] [1, 1] : tensor<2x?xf32> into tensor<3x?xf32>
    return %inserted_slice : tensor<3x?xf32>
  }
}

