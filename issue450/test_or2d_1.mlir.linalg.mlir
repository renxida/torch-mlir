#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map3 = affine_map<(d0, d1, d2) -> (d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_or2d(%arg0: tensor<3x4xi1>, %arg1: tensor<3x4xi1>) -> tensor<3x4xi1> {
    %0 = tensor.empty() : tensor<3x4xi1>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4xi1>, tensor<3x4xi1>) outs(%0 : tensor<3x4xi1>) {
    ^bb0(%in: i1, %in_0: i1, %out: i1):
      %2 = arith.ori %in, %in_0 : i1
      linalg.yield %2 : i1
    } -> tensor<3x4xi1>
    return %1 : tensor<3x4xi1>
  }
  func.func @test_identity(%arg0: tensor<3x4xf32>) -> tensor<3x4xf32> {
    return %arg0 : tensor<3x4xf32>
  }
  func.func @test_mean_one_input(%arg0: tensor<3xf32>) -> tensor<3xf32> {
    return %arg0 : tensor<3xf32>
  }
  func.func @test_mean_two_inputs(%arg0: tensor<3xf32>, %arg1: tensor<3xf32>) -> tensor<3xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%arg0, %arg1 : tensor<3xf32>, tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %3 = arith.addf %in, %in_0 : f32
      linalg.yield %3 : f32
    } -> tensor<3xf32>
    %2 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%1 : tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %3 = arith.divf %in, %cst : f32
      linalg.yield %3 : f32
    } -> tensor<3xf32>
    return %2 : tensor<3xf32>
  }
  func.func @test_isinf_negative(%arg0: tensor<6xf32>) -> tensor<6xi1> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0x7FF0000000000000 : f64
    %0 = tensor.empty() : tensor<6xf32>
    %1 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xf32>) outs(%0 : tensor<6xf32>) {
    ^bb0(%in: f32, %out: f32):
      %6 = arith.negf %in : f32
      linalg.yield %6 : f32
    } -> tensor<6xf32>
    %2 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%1 : tensor<6xf32>) outs(%0 : tensor<6xf32>) {
    ^bb0(%in: f32, %out: f32):
      %6 = arith.cmpf ugt, %in, %cst : f32
      %7 = arith.select %6, %in, %cst : f32
      linalg.yield %7 : f32
    } -> tensor<6xf32>
    %3 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%2 : tensor<6xf32>) outs(%0 : tensor<6xf32>) {
    ^bb0(%in: f32, %out: f32):
      %6 = math.absf %in : f32
      linalg.yield %6 : f32
    } -> tensor<6xf32>
    %4 = tensor.empty() : tensor<6xi1>
    %5 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%3 : tensor<6xf32>) outs(%4 : tensor<6xi1>) {
    ^bb0(%in: f32, %out: i1):
      %6 = arith.extf %in : f32 to f64
      %7 = arith.cmpf oeq, %6, %cst_0 : f64
      linalg.yield %7 : i1
    } -> tensor<6xi1>
    return %5 : tensor<6xi1>
  }
  func.func @test_isinf_positive(%arg0: tensor<6xf32>) -> tensor<6xi1> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 0x7FF0000000000000 : f64
    %0 = tensor.empty() : tensor<6xf32>
    %1 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xf32>) outs(%0 : tensor<6xf32>) {
    ^bb0(%in: f32, %out: f32):
      %5 = arith.cmpf ugt, %in, %cst : f32
      %6 = arith.select %5, %in, %cst : f32
      linalg.yield %6 : f32
    } -> tensor<6xf32>
    %2 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%1 : tensor<6xf32>) outs(%0 : tensor<6xf32>) {
    ^bb0(%in: f32, %out: f32):
      %5 = math.absf %in : f32
      linalg.yield %5 : f32
    } -> tensor<6xf32>
    %3 = tensor.empty() : tensor<6xi1>
    %4 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%2 : tensor<6xf32>) outs(%3 : tensor<6xi1>) {
    ^bb0(%in: f32, %out: i1):
      %5 = arith.extf %in : f32 to f64
      %6 = arith.cmpf oeq, %5, %cst_0 : f64
      linalg.yield %6 : i1
    } -> tensor<6xi1>
    return %4 : tensor<6xi1>
  }
  func.func @test_isnan(%arg0: tensor<6xf32>) -> tensor<6xi1> {
    %0 = tensor.empty() : tensor<6xi1>
    %1 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%arg0, %arg0 : tensor<6xf32>, tensor<6xf32>) outs(%0 : tensor<6xi1>) {
    ^bb0(%in: f32, %in_0: f32, %out: i1):
      %2 = arith.cmpf une, %in, %in_0 : f32
      linalg.yield %2 : i1
    } -> tensor<6xi1>
    return %1 : tensor<6xi1>
  }
  func.func @test_prelu_example(%arg0: tensor<3x4x5xf32>, %arg1: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5xf32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %5 = arith.mulf %in, %in_0 : f32
      linalg.yield %5 : f32
    } -> tensor<3x4x5xf32>
    %2 = tensor.empty() : tensor<3x4x5xi1>
    %3 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%2 : tensor<3x4x5xi1>) {
    ^bb0(%in: f32, %out: i1):
      %5 = arith.extf %in : f32 to f64
      %6 = arith.cmpf olt, %5, %cst : f64
      linalg.yield %6 : i1
    } -> tensor<3x4x5xi1>
    %4 = linalg.generic {indexing_maps = [#map2, #map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%3, %1, %arg0 : tensor<3x4x5xi1>, tensor<3x4x5xf32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: i1, %in_0: f32, %in_1: f32, %out: f32):
      %5 = arith.select %in, %in_0, %in_1 : f32
      linalg.yield %5 : f32
    } -> tensor<3x4x5xf32>
    return %4 : tensor<3x4x5xf32>
  }
  func.func @test_prelu_broadcast(%arg0: tensor<3x4x5xf32>, %arg1: tensor<5xf32>) -> tensor<3x4x5xf32> {
    %cst = arith.constant 0.000000e+00 : f64
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map2, #map3, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0, %arg1 : tensor<3x4x5xf32>, tensor<5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %5 = arith.mulf %in, %in_0 : f32
      linalg.yield %5 : f32
    } -> tensor<3x4x5xf32>
    %2 = tensor.empty() : tensor<3x4x5xi1>
    %3 = linalg.generic {indexing_maps = [#map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%2 : tensor<3x4x5xi1>) {
    ^bb0(%in: f32, %out: i1):
      %5 = arith.extf %in : f32 to f64
      %6 = arith.cmpf olt, %5, %cst : f64
      linalg.yield %6 : i1
    } -> tensor<3x4x5xi1>
    %4 = linalg.generic {indexing_maps = [#map2, #map2, #map2, #map2], iterator_types = ["parallel", "parallel", "parallel"]} ins(%3, %1, %arg0 : tensor<3x4x5xi1>, tensor<3x4x5xf32>, tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: i1, %in_0: f32, %in_1: f32, %out: f32):
      %5 = arith.select %in, %in_0, %in_1 : f32
      linalg.yield %5 : f32
    } -> tensor<3x4x5xf32>
    return %4 : tensor<3x4x5xf32>
  }
}

