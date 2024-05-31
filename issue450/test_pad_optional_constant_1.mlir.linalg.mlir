module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_pad_optional_constant(%arg0: tensor<3x4xf32>, %arg1: tensor<4xi64>) -> tensor<5x4xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg1[0] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed = tensor.collapse_shape %extracted_slice [] : tensor<1xi64> into tensor<i64>
    %extracted = tensor.extract %collapsed[] : tensor<i64>
    %extracted_slice_0 = tensor.extract_slice %arg1[1] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed_1 = tensor.collapse_shape %extracted_slice_0 [] : tensor<1xi64> into tensor<i64>
    %extracted_2 = tensor.extract %collapsed_1[] : tensor<i64>
    %extracted_slice_3 = tensor.extract_slice %arg1[2] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed_4 = tensor.collapse_shape %extracted_slice_3 [] : tensor<1xi64> into tensor<i64>
    %extracted_5 = tensor.extract %collapsed_4[] : tensor<i64>
    %extracted_slice_6 = tensor.extract_slice %arg1[3] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed_7 = tensor.collapse_shape %extracted_slice_6 [] : tensor<1xi64> into tensor<i64>
    %extracted_8 = tensor.extract %collapsed_7[] : tensor<i64>
    %0 = arith.index_cast %extracted_2 : i64 to index
    %1 = arith.index_cast %extracted_8 : i64 to index
    %2 = arith.index_cast %extracted : i64 to index
    %3 = arith.index_cast %extracted_5 : i64 to index
    %padded = tensor.pad %arg0 low[%0, %2] high[%1, %3] {
    ^bb0(%arg2: index, %arg3: index):
      tensor.yield %cst : f32
    } : tensor<3x4xf32> to tensor<5x4xf32>
    return %padded : tensor<5x4xf32>
  }
}

