#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_matmulinteger(%arg0: tensor<4x3xi8>, %arg1: tensor<3x2xi8>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>) -> tensor<4x2xi32> {
    %c-128_i8 = arith.constant -128 : i8
    %c-128_i32 = arith.constant -128 : i32
    %c0_i32 = arith.constant 0 : i32
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg2[%c0] : tensor<1xi8>
    %extracted_0 = tensor.extract %arg3[%c0] : tensor<1xi8>
    %0 = tensor.empty() : tensor<4x2xi32>
    %1 = linalg.fill ins(%c0_i32 : i32) outs(%0 : tensor<4x2xi32>) -> tensor<4x2xi32>
    %2 = arith.extui %extracted : i8 to i32
    %3 = arith.extui %extracted_0 : i8 to i32
    %4 = arith.addi %2, %c-128_i32 : i32
    %5 = tensor.empty() : tensor<4x3xi8>
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg0 : tensor<4x3xi8>) outs(%5 : tensor<4x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      %11 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %11 : i8
    } -> tensor<4x3xi8>
    %7 = arith.addi %3, %c-128_i32 : i32
    %8 = tensor.empty() : tensor<3x2xi8>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<3x2xi8>) outs(%8 : tensor<3x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %11 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %11 : i8
    } -> tensor<3x2xi8>
    %10 = linalg.quantized_matmul ins(%6, %9, %4, %7 : tensor<4x3xi8>, tensor<3x2xi8>, i32, i32) outs(%1 : tensor<4x2xi32>) -> tensor<4x2xi32>
    return %10 : tensor<4x2xi32>
  }
}

