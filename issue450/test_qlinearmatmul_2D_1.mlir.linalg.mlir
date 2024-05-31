#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_qlinearmatmul_2D(%arg0: tensor<2x4xi8>, %arg1: tensor<1xf32>, %arg2: tensor<1xi8>, %arg3: tensor<4x3xi8>, %arg4: tensor<1xf32>, %arg5: tensor<1xi8>, %arg6: tensor<1xf32>, %arg7: tensor<1xi8>) -> tensor<2x3xi8> {
    %c0_i32 = arith.constant 0 : i32
    %c-128_i32 = arith.constant -128 : i32
    %c-128_i8 = arith.constant -128 : i8
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 2.550000e+02 : f32
    %collapsed = tensor.collapse_shape %arg2 [] : tensor<1xi8> into tensor<i8>
    %extracted = tensor.extract %collapsed[] : tensor<i8>
    %collapsed_1 = tensor.collapse_shape %arg5 [] : tensor<1xi8> into tensor<i8>
    %extracted_2 = tensor.extract %collapsed_1[] : tensor<i8>
    %collapsed_3 = tensor.collapse_shape %arg7 [] : tensor<1xi8> into tensor<i8>
    %extracted_4 = tensor.extract %collapsed_3[] : tensor<i8>
    %0 = arith.extui %extracted_4 : i8 to i64
    %collapsed_5 = tensor.collapse_shape %arg1 [] : tensor<1xf32> into tensor<f32>
    %extracted_6 = tensor.extract %collapsed_5[] : tensor<f32>
    %1 = arith.extf %extracted_6 : f32 to f64
    %collapsed_7 = tensor.collapse_shape %arg4 [] : tensor<1xf32> into tensor<f32>
    %extracted_8 = tensor.extract %collapsed_7[] : tensor<f32>
    %2 = arith.extf %extracted_8 : f32 to f64
    %collapsed_9 = tensor.collapse_shape %arg6 [] : tensor<1xf32> into tensor<f32>
    %extracted_10 = tensor.extract %collapsed_9[] : tensor<f32>
    %3 = arith.extf %extracted_10 : f32 to f64
    %4 = tensor.empty() : tensor<2x3xi32>
    %5 = linalg.fill ins(%c0_i32 : i32) outs(%4 : tensor<2x3xi32>) -> tensor<2x3xi32>
    %6 = arith.extui %extracted : i8 to i32
    %7 = arith.extui %extracted_2 : i8 to i32
    %8 = arith.addi %6, %c-128_i32 : i32
    %9 = tensor.empty() : tensor<2x4xi8>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<2x4xi8>) outs(%9 : tensor<2x4xi8>) {
    ^bb0(%in: i8, %out: i8):
      %20 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %20 : i8
    } -> tensor<2x4xi8>
    %11 = arith.addi %7, %c-128_i32 : i32
    %12 = tensor.empty() : tensor<4x3xi8>
    %13 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg3 : tensor<4x3xi8>) outs(%12 : tensor<4x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      %20 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %20 : i8
    } -> tensor<4x3xi8>
    %14 = linalg.quantized_matmul ins(%10, %13, %8, %11 : tensor<2x4xi8>, tensor<4x3xi8>, i32, i32) outs(%5 : tensor<2x3xi32>) -> tensor<2x3xi32>
    %15 = arith.mulf %1, %2 : f64
    %16 = tensor.empty() : tensor<2x3xf32>
    %17 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%14 : tensor<2x3xi32>) outs(%16 : tensor<2x3xf32>) {
    ^bb0(%in: i32, %out: f32):
      %20 = arith.sitofp %in : i32 to f32
      %21 = arith.truncf %15 : f64 to f32
      %22 = arith.mulf %20, %21 : f32
      linalg.yield %22 : f32
    } -> tensor<2x3xf32>
    %18 = tensor.empty() : tensor<2x3xi8>
    %19 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%17 : tensor<2x3xf32>) outs(%18 : tensor<2x3xi8>) {
    ^bb0(%in: f32, %out: i8):
      %20 = arith.sitofp %0 : i64 to f32
      %21 = arith.truncf %3 : f64 to f32
      %22 = arith.divf %in, %21 : f32
      %23 = math.round %22 : f32
      %24 = arith.addf %23, %20 : f32
      %25 = arith.cmpf ult, %24, %cst : f32
      %26 = arith.cmpf ugt, %24, %cst_0 : f32
      %27 = arith.select %25, %cst, %24 : f32
      %28 = arith.select %26, %cst_0, %27 : f32
      %29 = arith.fptoui %28 : f32 to i8
      linalg.yield %29 : i8
    } -> tensor<2x3xi8>
    return %19 : tensor<2x3xi8>
  }
}

