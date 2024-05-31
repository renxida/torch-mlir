#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
#map1 = affine_map<(d0, d1) -> (d0, d1)>
#map2 = affine_map<(d0, d1, d2) -> (d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_matmulinteger_batched(%arg0: tensor<7x4x3xi8>, %arg1: tensor<3x2xi8>, %arg2: tensor<1xi8>, %arg3: tensor<1xi8>) -> tensor<7x4x2xi32> {
    %c0_i32 = arith.constant 0 : i32
    %c-128_i8 = arith.constant -128 : i8
    %c-128_i32 = arith.constant -128 : i32
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg2[%c0] : tensor<1xi8>
    %extracted_0 = tensor.extract %arg3[%c0] : tensor<1xi8>
    %0 = arith.extui %extracted : i8 to i32
    %1 = arith.extui %extracted_0 : i8 to i32
    %2 = arith.addi %0, %c-128_i32 : i32
    %3 = tensor.empty() : tensor<7x4x3xi8>
    %4 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<7x4x3xi8>) outs(%3 : tensor<7x4x3xi8>) {
    ^bb0(%in: i8, %out: i8):
      %13 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %13 : i8
    } -> tensor<7x4x3xi8>
    %5 = arith.addi %1, %c-128_i32 : i32
    %6 = tensor.empty() : tensor<3x2xi8>
    %7 = linalg.generic {indexing_maps = [#map1, #map1], iterator_types = ["parallel", "parallel"]} ins(%arg1 : tensor<3x2xi8>) outs(%6 : tensor<3x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      %13 = arith.addi %in, %c-128_i8 : i8
      linalg.yield %13 : i8
    } -> tensor<3x2xi8>
    %8 = tensor.empty() : tensor<7x3x2xi8>
    %9 = linalg.generic {indexing_maps = [#map2, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%7 : tensor<3x2xi8>) outs(%8 : tensor<7x3x2xi8>) {
    ^bb0(%in: i8, %out: i8):
      linalg.yield %in : i8
    } -> tensor<7x3x2xi8>
    %10 = tensor.empty() : tensor<7x4x2xi32>
    %11 = linalg.fill ins(%c0_i32 : i32) outs(%10 : tensor<7x4x2xi32>) -> tensor<7x4x2xi32>
    %12 = linalg.quantized_batch_matmul ins(%4, %9, %2, %5 : tensor<7x4x3xi8>, tensor<7x3x2xi8>, i32, i32) outs(%11 : tensor<7x4x2xi32>) -> tensor<7x4x2xi32>
    return %12 : tensor<7x4x2xi32>
  }
}

