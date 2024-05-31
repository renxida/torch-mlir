module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_split_2d_uneven_split_opset18(%arg0: tensor<2x8xf32>) -> (tensor<2x3xf32>, tensor<2x3xf32>, tensor<2x2xf32>) {
    %extracted_slice = tensor.extract_slice %arg0[0, 0] [2, 3] [1, 1] : tensor<2x8xf32> to tensor<2x3xf32>
    %extracted_slice_0 = tensor.extract_slice %arg0[0, 3] [2, 3] [1, 1] : tensor<2x8xf32> to tensor<2x3xf32>
    %extracted_slice_1 = tensor.extract_slice %arg0[0, 6] [2, 2] [1, 1] : tensor<2x8xf32> to tensor<2x2xf32>
    return %extracted_slice, %extracted_slice_0, %extracted_slice_1 : tensor<2x3xf32>, tensor<2x3xf32>, tensor<2x2xf32>
  }
}

