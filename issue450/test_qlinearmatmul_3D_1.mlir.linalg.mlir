#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_qlinearmatmul_3D(%arg0: tensor<2x2x4xi8>, %arg1: tensor<1xf32>, %arg2: tensor<1xi8>, %arg3: tensor<2x4x3xi8>, %arg4: tensor<1xf32>, %arg5: tensor<1xi8>, %arg6: tensor<1xf32>, %arg7: tensor<1xi8>) -> tensor<2x2x3xi8> {
    %c0_i32 = arith.constant 0 : i32
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 2.550000e+02 : f32
    %collapsed = tensor.collapse_shape %arg7 [] : tensor<1xi8> into tensor<i8>
    %extracted = tensor.extract %collapsed[] : tensor<i8>
    %0 = arith.extui %extracted : i8 to i64
    %collapsed_1 = tensor.collapse_shape %arg1 [] : tensor<1xf32> into tensor<f32>
    %extracted_2 = tensor.extract %collapsed_1[] : tensor<f32>
    %1 = arith.extf %extracted_2 : f32 to f64
    %collapsed_3 = tensor.collapse_shape %arg4 [] : tensor<1xf32> into tensor<f32>
    %extracted_4 = tensor.extract %collapsed_3[] : tensor<f32>
    %2 = arith.extf %extracted_4 : f32 to f64
    %collapsed_5 = tensor.collapse_shape %arg6 [] : tensor<1xf32> into tensor<f32>
    %extracted_6 = tensor.extract %collapsed_5[] : tensor<f32>
    %3 = arith.extf %extracted_6 : f32 to f64
    %4 = tensor.empty() : tensor<2x2x3xi32>
    %5 = linalg.fill ins(%c0_i32 : i32) outs(%4 : tensor<2x2x3xi32>) -> tensor<2x2x3xi32>
    %6 = linalg.batch_matmul ins(%arg0, %arg3 : tensor<2x2x4xi8>, tensor<2x4x3xi8>) outs(%5 : tensor<2x2x3xi32>) -> tensor<2x2x3xi32>
    %7 = arith.mulf %1, %2 : f64
    %8 = tensor.empty() : tensor<2x2x3xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%6 : tensor<2x2x3xi32>) outs(%8 : tensor<2x2x3xf32>) {
    ^bb0(%in: i32, %out: f32):
      %12 = arith.sitofp %in : i32 to f32
      %13 = arith.truncf %7 : f64 to f32
      %14 = arith.mulf %12, %13 : f32
      linalg.yield %14 : f32
    } -> tensor<2x2x3xf32>
    %10 = tensor.empty() : tensor<2x2x3xi8>
    %11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%9 : tensor<2x2x3xf32>) outs(%10 : tensor<2x2x3xi8>) {
    ^bb0(%in: f32, %out: i8):
      %12 = arith.sitofp %0 : i64 to f32
      %13 = arith.truncf %3 : f64 to f32
      %14 = arith.divf %in, %13 : f32
      %15 = math.round %14 : f32
      %16 = arith.addf %15, %12 : f32
      %17 = arith.cmpf ult, %16, %cst : f32
      %18 = arith.cmpf ugt, %16, %cst_0 : f32
      %19 = arith.select %17, %cst, %16 : f32
      %20 = arith.select %18, %cst_0, %19 : f32
      %21 = arith.fptoui %20 : f32 to i8
      linalg.yield %21 : i8
    } -> tensor<2x2x3xi8>
    return %11 : tensor<2x2x3xi8>
  }
}

