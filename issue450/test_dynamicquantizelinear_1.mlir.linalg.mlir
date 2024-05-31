#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1, d2) -> ()>
#map2 = affine_map<() -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_dynamicquantizelinear(%arg0: tensor<3x4x5xf32>) -> (tensor<3x4x5xi8>, tensor<f32>, tensor<i8>) {
    %cst = arith.constant dense<0.000000e+00> : tensor<f64>
    %cst_0 = arith.constant 0xFF800000 : f32
    %cst_1 = arith.constant 0x7F800000 : f32
    %cst_2 = arith.constant 0.000000e+00 : f32
    %cst_3 = arith.constant 2.550000e+02 : f32
    %cst_4 = arith.constant dense<2.550000e+02> : tensor<f64>
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.fill ins(%cst_0 : f32) outs(%0 : tensor<f32>) -> tensor<f32>
    %2 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction", "reduction"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%1 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %21 = arith.maximumf %in, %out : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %3 = linalg.fill ins(%cst_1 : f32) outs(%0 : tensor<f32>) -> tensor<f32>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["reduction", "reduction", "reduction"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%3 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %21 = arith.minimumf %in, %out : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %5 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%cst : tensor<f64>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %21 = arith.truncf %in : f64 to f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %6 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%2, %5 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %21 = arith.cmpf ogt, %in, %in_6 : f32
      %22 = arith.select %21, %in, %in_6 : f32
      linalg.yield %22 : f32
    } -> tensor<f32>
    %7 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%4, %5 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %21 = arith.cmpf olt, %in, %in_6 : f32
      %22 = arith.select %21, %in, %in_6 : f32
      linalg.yield %22 : f32
    } -> tensor<f32>
    %8 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%6, %7 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %21 = arith.subf %in, %in_6 : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %9 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%cst_4 : tensor<f64>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f64, %out: f32):
      %21 = arith.truncf %in : f64 to f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %10 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%8, %9 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %21 = arith.divf %in, %in_6 : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %11 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%4, %10 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %21 = arith.divf %in, %in_6 : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %12 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = []} ins(%5, %11 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %21 = arith.subf %in, %in_6 : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %13 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%12 : tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %21 = arith.cmpf ult, %in, %cst_2 : f32
      %22 = arith.select %21, %cst_2, %in : f32
      %23 = arith.cmpf ugt, %22, %cst_3 : f32
      %24 = arith.select %23, %cst_3, %22 : f32
      linalg.yield %24 : f32
    } -> tensor<f32>
    %14 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%13 : tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %21 = math.roundeven %in : f32
      linalg.yield %21 : f32
    } -> tensor<f32>
    %15 = tensor.empty() : tensor<i8>
    %16 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = []} ins(%14 : tensor<f32>) outs(%15 : tensor<i8>) {
    ^bb0(%in: f32, %out: i8):
      %21 = arith.fptosi %in : f32 to i8
      linalg.yield %21 : i8
    } -> tensor<i8>
    %extracted = tensor.extract %16[] : tensor<i8>
    %17 = arith.extui %extracted : i8 to i64
    %extracted_5 = tensor.extract %10[] : tensor<f32>
    %18 = arith.extf %extracted_5 : f32 to f64
    %19 = tensor.empty() : tensor<3x4x5xi8>
    %20 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%19 : tensor<3x4x5xi8>) {
    ^bb0(%in: f32, %out: i8):
      %21 = arith.sitofp %17 : i64 to f32
      %22 = arith.truncf %18 : f64 to f32
      %23 = arith.divf %in, %22 : f32
      %24 = math.round %23 : f32
      %25 = arith.addf %24, %21 : f32
      %26 = arith.cmpf ult, %25, %cst_2 : f32
      %27 = arith.cmpf ugt, %25, %cst_3 : f32
      %28 = arith.select %26, %cst_2, %25 : f32
      %29 = arith.select %27, %cst_3, %28 : f32
      %30 = arith.fptoui %29 : f32 to i8
      linalg.yield %30 : i8
    } -> tensor<3x4x5xi8>
    return %20, %10, %16 : tensor<3x4x5xi8>, tensor<f32>, tensor<i8>
  }
}

