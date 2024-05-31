module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_pad(%arg0: tensor<3x4xf32>, %arg1: tensor<4xi64>, %arg2: tensor<f32>) -> tensor<5x4xf32> {
    %extracted = tensor.extract %arg2[] : tensor<f32>
    %0 = arith.extf %extracted : f32 to f64
    %extracted_slice = tensor.extract_slice %arg1[0] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed = tensor.collapse_shape %extracted_slice [] : tensor<1xi64> into tensor<i64>
    %extracted_0 = tensor.extract %collapsed[] : tensor<i64>
    %extracted_slice_1 = tensor.extract_slice %arg1[1] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed_2 = tensor.collapse_shape %extracted_slice_1 [] : tensor<1xi64> into tensor<i64>
    %extracted_3 = tensor.extract %collapsed_2[] : tensor<i64>
    %extracted_slice_4 = tensor.extract_slice %arg1[2] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed_5 = tensor.collapse_shape %extracted_slice_4 [] : tensor<1xi64> into tensor<i64>
    %extracted_6 = tensor.extract %collapsed_5[] : tensor<i64>
    %extracted_slice_7 = tensor.extract_slice %arg1[3] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %collapsed_8 = tensor.collapse_shape %extracted_slice_7 [] : tensor<1xi64> into tensor<i64>
    %extracted_9 = tensor.extract %collapsed_8[] : tensor<i64>
    %1 = arith.index_cast %extracted_3 : i64 to index
    %2 = arith.index_cast %extracted_9 : i64 to index
    %3 = arith.index_cast %extracted_0 : i64 to index
    %4 = arith.index_cast %extracted_6 : i64 to index
    %5 = arith.truncf %0 : f64 to f32
    %padded = tensor.pad %arg0 low[%1, %3] high[%2, %4] {
    ^bb0(%arg3: index, %arg4: index):
      tensor.yield %5 : f32
    } : tensor<3x4xf32> to tensor<5x4xf32>
    return %padded : tensor<5x4xf32>
  }
}

