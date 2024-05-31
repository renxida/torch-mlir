#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_mish(%arg0: tensor<10000xf32>) -> tensor<10000xf32> {
    %cst = arith.constant 2.000000e+01 : f64
    %0 = tensor.empty() : tensor<10000xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<10000xf32>) outs(%0 : tensor<10000xf32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = math.exp %in : f32
      linalg.yield %8 : f32
    } -> tensor<10000xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%1 : tensor<10000xf32>) outs(%0 : tensor<10000xf32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = math.log1p %in : f32
      linalg.yield %8 : f32
    } -> tensor<10000xf32>
    %3 = tensor.empty() : tensor<10000xi1>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<10000xf32>) outs(%3 : tensor<10000xi1>) {
    ^bb0(%in: f32, %out: i1):
      %8 = arith.extf %in : f32 to f64
      %9 = arith.cmpf ogt, %8, %cst : f64
      linalg.yield %9 : i1
    } -> tensor<10000xi1>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map, #map], iterator_types = ["parallel"]} ins(%4, %arg0, %2 : tensor<10000xi1>, tensor<10000xf32>, tensor<10000xf32>) outs(%0 : tensor<10000xf32>) {
    ^bb0(%in: i1, %in_0: f32, %in_1: f32, %out: f32):
      %8 = arith.select %in, %in_0, %in_1 : f32
      linalg.yield %8 : f32
    } -> tensor<10000xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%5 : tensor<10000xf32>) outs(%0 : tensor<10000xf32>) {
    ^bb0(%in: f32, %out: f32):
      %8 = math.tanh %in : f32
      linalg.yield %8 : f32
    } -> tensor<10000xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%arg0, %6 : tensor<10000xf32>, tensor<10000xf32>) outs(%0 : tensor<10000xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %8 = arith.mulf %in, %in_0 : f32
      linalg.yield %8 : f32
    } -> tensor<10000xf32>
    return %7 : tensor<10000xf32>
  }
}

