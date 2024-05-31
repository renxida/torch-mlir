#map = affine_map<(d0, d1, d2, d3) -> (0, 0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
#map2 = affine_map<(d0, d1, d2, d3) -> (0, 0, 0, 0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_qlinearconv_nobias(%arg0: tensor<1x1x7x7xi8>, %arg1: tensor<f32>, %arg2: tensor<i8>, %arg3: tensor<1x1x1x1xi8>, %arg4: tensor<1xf32>, %arg5: tensor<1xi8>, %arg6: tensor<f32>, %arg7: tensor<i8>) -> tensor<1x1x7x7xi8> {
    %cst = arith.constant 2.550000e+02 : f32
    %cst_0 = arith.constant 0.000000e+00 : f32
    %c0_i32 = arith.constant 0 : i32
    %c-128_i8 = arith.constant -128 : i8
    %c-128_i64 = arith.constant -128 : i64
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg2[] : tensor<i8>
    %0 = arith.extui %extracted : i8 to i64
    %extracted_1 = tensor.extract %arg5[%c0] : tensor<1xi8>
    %1 = arith.extui %extracted_1 : i8 to i64
    %extracted_2 = tensor.extract %arg7[] : tensor<i8>
    %2 = arith.extui %extracted_2 : i8 to i64
    %extracted_3 = tensor.extract %arg1[] : tensor<f32>
    %3 = arith.extf %extracted_3 : f32 to f64
    %extracted_4 = tensor.extract %arg4[%c0] : tensor<1xf32>
    %4 = arith.extf %extracted_4 : f32 to f64
    %extracted_5 = tensor.extract %arg6[] : tensor<f32>
    %5 = arith.extf %extracted_5 : f32 to f64
    %6 = arith.addi %0, %c-128_i64 : i64
    %7 = tensor.empty() : tensor<1x1x7x7xi8>
    %8 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x1x7x7xi8>) outs(%7 : tensor<1x1x7x7xi8>) {
    ^bb0(%in: i8, %out: i8):
      %21 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %21 : i8
    } -> tensor<1x1x7x7xi8>
    %9 = arith.addi %1, %c-128_i64 : i64
    %10 = tensor.empty() : tensor<1x1x1x1xi8>
    %11 = linalg.generic {indexing_maps = [#map2, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg3 : tensor<1x1x1x1xi8>) outs(%10 : tensor<1x1x1x1xi8>) {
    ^bb0(%in: i8, %out: i8):
      %21 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %21 : i8
    } -> tensor<1x1x1x1xi8>
    %12 = tensor.empty() : tensor<1x7x7x1xi8>
    %transposed = linalg.transpose ins(%8 : tensor<1x1x7x7xi8>) outs(%12 : tensor<1x7x7x1xi8>) permutation = [0, 2, 3, 1] 
    %transposed_6 = linalg.transpose ins(%11 : tensor<1x1x1x1xi8>) outs(%10 : tensor<1x1x1x1xi8>) permutation = [2, 3, 1, 0] 
    %13 = tensor.empty() : tensor<1x7x7x1xi32>
    %14 = linalg.fill ins(%c0_i32 : i32) outs(%13 : tensor<1x7x7x1xi32>) -> tensor<1x7x7x1xi32>
    %15 = linalg.conv_2d_nhwc_hwcf_q {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%transposed, %transposed_6, %6, %9 : tensor<1x7x7x1xi8>, tensor<1x1x1x1xi8>, i64, i64) outs(%14 : tensor<1x7x7x1xi32>) -> tensor<1x7x7x1xi32>
    %16 = tensor.empty() : tensor<1x1x7x7xi32>
    %transposed_7 = linalg.transpose ins(%15 : tensor<1x7x7x1xi32>) outs(%16 : tensor<1x1x7x7xi32>) permutation = [0, 3, 1, 2] 
    %17 = arith.mulf %3, %4 : f64
    %18 = tensor.empty() : tensor<1x1x7x7xf32>
    %19 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%transposed_7 : tensor<1x1x7x7xi32>) outs(%18 : tensor<1x1x7x7xf32>) {
    ^bb0(%in: i32, %out: f32):
      %21 = arith.sitofp %in : i32 to f32
      %22 = arith.truncf %17 : f64 to f32
      %23 = arith.mulf %21, %22 : f32
      linalg.yield %23 : f32
    } -> tensor<1x1x7x7xf32>
    %20 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%19 : tensor<1x1x7x7xf32>) outs(%7 : tensor<1x1x7x7xi8>) {
    ^bb0(%in: f32, %out: i8):
      %21 = arith.sitofp %2 : i64 to f32
      %22 = arith.truncf %5 : f64 to f32
      %23 = arith.divf %in, %22 : f32
      %24 = math.round %23 : f32
      %25 = arith.addf %24, %21 : f32
      %26 = arith.cmpf ult, %25, %cst_0 : f32
      %27 = arith.cmpf ugt, %25, %cst : f32
      %28 = arith.select %26, %cst_0, %25 : f32
      %29 = arith.select %27, %cst, %28 : f32
      %30 = arith.fptoui %29 : f32 to i8
      linalg.yield %30 : i8
    } -> tensor<1x1x7x7xi8>
    return %20 : tensor<1x1x7x7xi8>
  }
}

