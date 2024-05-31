#map = affine_map<() -> ()>
#map1 = affine_map<(d0) -> (d0)>
#map2 = affine_map<(d0) -> ()>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_blackmanwindow(%arg0: tensor<i32>) -> tensor<10xf32> {
    %cst = arith.constant -5.000000e-01 : f32
    %cst_0 = arith.constant 2.000000e+00 : f32
    %cst_1 = arith.constant 0.000000e+00 : f32
    %cst_2 = arith.constant 1.000000e+00 : f32
    %cst_3 = arith.constant 6.2831853071795862 : f64
    %cst_4 = arith.constant 8.000000e-02 : f64
    %cst_5 = arith.constant 4.200000e-01 : f64
    %0 = tensor.empty() : tensor<f32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%arg0 : tensor<i32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: i32, %out: f32):
      %16 = arith.sitofp %in : i32 to f32
      linalg.yield %16 : f32
    } -> tensor<f32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%1 : tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.subf %in, %cst_2 : f32
      linalg.yield %16 : f32
    } -> tensor<f32>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = []} ins(%2 : tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.mulf %in, %cst_1 : f32
      linalg.yield %16 : f32
    } -> tensor<f32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = []} ins(%3, %1 : tensor<f32>, tensor<f32>) outs(%0 : tensor<f32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %16 = arith.addf %in, %in_6 : f32
      linalg.yield %16 : f32
    } -> tensor<f32>
    %5 = tensor.empty() : tensor<10xf32>
    %6 = linalg.generic {indexing_maps = [#map1], iterator_types = ["parallel"]} outs(%5 : tensor<10xf32>) {
    ^bb0(%out: f32):
      %16 = linalg.index 0 : index
      %17 = arith.index_cast %16 : index to i64
      %18 = arith.sitofp %17 : i64 to f32
      %19 = arith.addf %18, %cst_1 : f32
      linalg.yield %19 : f32
    } -> tensor<10xf32>
    %7 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%6 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.truncf %cst_3 : f64 to f32
      %17 = arith.mulf %in, %16 : f32
      linalg.yield %17 : f32
    } -> tensor<10xf32>
    %8 = linalg.generic {indexing_maps = [#map1, #map2, #map1], iterator_types = ["parallel"]} ins(%7, %4 : tensor<10xf32>, tensor<f32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %16 = arith.divf %in, %in_6 : f32
      linalg.yield %16 : f32
    } -> tensor<10xf32>
    %9 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%8 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.mulf %in, %cst_0 : f32
      linalg.yield %16 : f32
    } -> tensor<10xf32>
    %10 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%8 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = math.cos %in : f32
      linalg.yield %16 : f32
    } -> tensor<10xf32>
    %11 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%9 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = math.cos %in : f32
      linalg.yield %16 : f32
    } -> tensor<10xf32>
    %12 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%10 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.mulf %in, %cst : f32
      linalg.yield %16 : f32
    } -> tensor<10xf32>
    %13 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%11 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.truncf %cst_4 : f64 to f32
      %17 = arith.mulf %in, %16 : f32
      linalg.yield %17 : f32
    } -> tensor<10xf32>
    %14 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel"]} ins(%12 : tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %16 = arith.truncf %cst_5 : f64 to f32
      %17 = arith.addf %in, %16 : f32
      linalg.yield %17 : f32
    } -> tensor<10xf32>
    %15 = linalg.generic {indexing_maps = [#map1, #map1, #map1], iterator_types = ["parallel"]} ins(%14, %13 : tensor<10xf32>, tensor<10xf32>) outs(%5 : tensor<10xf32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %16 = arith.addf %in, %in_6 : f32
      linalg.yield %16 : f32
    } -> tensor<10xf32>
    return %15 : tensor<10xf32>
  }
}

