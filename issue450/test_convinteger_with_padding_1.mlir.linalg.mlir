#map = affine_map<(d0, d1, d2, d3) -> (0, 0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_convinteger_with_padding(%arg0: tensor<1x1x3x3xi8>, %arg1: tensor<1x1x2x2xi8>, %arg2: tensor<i8>) -> tensor<1x1x4x4xi32> {
    %c0_i32 = arith.constant 0 : i32
    %c-128_i8 = arith.constant -128 : i8
    %c-128_i64 = arith.constant -128 : i64
    %extracted = tensor.extract %arg2[] : tensor<i8>
    %0 = arith.extui %extracted : i8 to i64
    %1 = arith.addi %0, %c-128_i64 : i64
    %2 = tensor.empty() : tensor<1x1x3x3xi8>
    %3 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg0 : tensor<1x1x3x3xi8>) outs(%2 : tensor<1x1x3x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      %13 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %13 : i8
    } -> tensor<1x1x3x3xi8>
    %4 = tensor.empty() : tensor<1x1x2x2xi8>
    %5 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%arg1 : tensor<1x1x2x2xi8>) outs(%4 : tensor<1x1x2x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %13 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %13 : i8
    } -> tensor<1x1x2x2xi8>
    %6 = arith.trunci %1 : i64 to i8
    %padded = tensor.pad %3 low[0, 0, 1, 1] high[0, 0, 1, 1] {
    ^bb0(%arg3: index, %arg4: index, %arg5: index, %arg6: index):
      tensor.yield %6 : i8
    } : tensor<1x1x3x3xi8> to tensor<1x1x5x5xi8>
    %7 = tensor.empty() : tensor<1x5x5x1xi8>
    %transposed = linalg.transpose ins(%padded : tensor<1x1x5x5xi8>) outs(%7 : tensor<1x5x5x1xi8>) permutation = [0, 2, 3, 1] 
    %8 = tensor.empty() : tensor<2x2x1x1xi8>
    %transposed_0 = linalg.transpose ins(%5 : tensor<1x1x2x2xi8>) outs(%8 : tensor<2x2x1x1xi8>) permutation = [2, 3, 1, 0] 
    %9 = tensor.empty() : tensor<1x4x4x1xi32>
    %10 = linalg.fill ins(%c0_i32 : i32) outs(%9 : tensor<1x4x4x1xi32>) -> tensor<1x4x4x1xi32>
    %11 = linalg.conv_2d_nhwc_hwcf_q {dilations = dense<1> : vector<2xi64>, strides = dense<1> : vector<2xi64>} ins(%transposed, %transposed_0, %1, %c-128_i64 : tensor<1x5x5x1xi8>, tensor<2x2x1x1xi8>, i64, i64) outs(%10 : tensor<1x4x4x1xi32>) -> tensor<1x4x4x1xi32>
    %12 = tensor.empty() : tensor<1x1x4x4xi32>
    %transposed_1 = linalg.transpose ins(%11 : tensor<1x4x4x1xi32>) outs(%12 : tensor<1x1x4x4xi32>) permutation = [0, 3, 1, 2] 
    return %transposed_1 : tensor<1x1x4x4xi32>
  }
}

