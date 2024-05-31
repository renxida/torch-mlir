module {
  func.func @test_compress_neg_axis(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,2,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.vtensor.literal(dense<[0, 1, 1]> : tensor<3xsi64>) : !torch.vtensor<[3],si64>
    %1 = torch.aten.nonzero %0 : !torch.vtensor<[3],si64> -> !torch.vtensor<[2],si64>
    %2 = torch.aten.index_select %arg0, %int1, %1 : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.vtensor<[2],si64> -> !torch.vtensor<[2,2,4],f32>
    return %2 : !torch.vtensor<[2,2,4],f32>
  }
}

