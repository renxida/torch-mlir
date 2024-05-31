#map = affine_map<(d0, d1, d2, d3) -> (0, 0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_convinteger_without_padding(%arg0: tensor<1x1x3x3xi8>, %arg1: tensor<1x1x2x2xi8>, %arg2: tensor<i8>, %arg3: tensor<1xi8>) -> tensor<1x1x2x2xi32> {
    %c0_i32 = arith.constant 0 : i32
    %c-128_i8 = arith.constant -128 : i8
    %c-128_i64 = arith.constant -128 : i64
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg2[] : tensor<i8>
    %0 = arith.extui %extracted : i8 to i64
    %extracted_0 = tensor.extract %arg3[%c0] : tensor<1xi8>
    %1 = arith.extui %extracted_0 : i8 to i64
    %2 = arith.addi %0, %c-128_i64 : i64
    %3 = tensor.empty() : tensor<1x1x3x3xi8>
    %4 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x1x3x3xi8>) outs(%3 : tensor<1x1x3x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      %14 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %14 : i8
    } -> tensor<1x1x3x3xi8>
    %5 = arith.addi %1, %c-128_i64 : i64
    %6 = tensor.empty() : tensor<1x1x2x2xi8>
    %7 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg1 : tensor<1x1x2x2xi8>) outs(%6 : tensor<1x1x2x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %14 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %14 : i8
    } -> tensor<1x1x2x2xi8>
    %8 = tensor.empty() : tensor<1x3x3x1xi8>
    %transposed = linalg.transpose ins(%4 : tensor<1x1x3x3xi8>) outs(%8 : tensor<1x3x3x1xi8>) permutation = [0, 2, 3, 1] 
    %9 = tensor.empty() : tensor<2x2x1x1xi8>
    %transposed_1 = linalg.transpose ins(%7 : tensor<1x1x2x2xi8>) outs(%9 : tensor<2x2x1x1xi8>) permutation = [2, 3, 1, 0] 
    %10 = tensor.empty() : tensor<1x2x2x1xi32>
    %11 = linalg.fill ins(%c0_i32 : i32) outs(%10 : tensor<1x2x2x1xi32>) -> tensor<1x2x2x1xi32>
    %12 = linalg.conv_2d_nhwc_hwcf_q {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%transposed, %transposed_1, %2, %5 : tensor<1x3x3x1xi8>, tensor<2x2x1x1xi8>, i64, i64) outs(%11 : tensor<1x2x2x1xi32>) -> tensor<1x2x2x1xi32>
    %13 = tensor.empty() : tensor<1x1x2x2xi32>
    %transposed_2 = linalg.transpose ins(%12 : tensor<1x2x2x1xi32>) outs(%13 : tensor<1x1x2x2xi32>) permutation = [0, 3, 1, 2] 
    return %transposed_2 : tensor<1x1x2x2xi32>
  }
}

