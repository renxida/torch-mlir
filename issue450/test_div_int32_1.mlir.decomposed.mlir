module {
  func.func @test_div_int32(%arg0: !torch.vtensor<[3,4,5],si32>, %arg1: !torch.vtensor<[3,4,5],si32>) -> !torch.vtensor<[3,4,5],si32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.div.Tensor %arg0, %arg1 : !torch.vtensor<[3,4,5],si32>, !torch.vtensor<[3,4,5],si32> -> !torch.vtensor<[3,4,5],si32>
    return %0 : !torch.vtensor<[3,4,5],si32>
  }
}

