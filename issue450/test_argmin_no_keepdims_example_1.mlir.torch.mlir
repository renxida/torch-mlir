module {
  func.func @test_argmin_no_keepdims_example(%arg0: !torch.vtensor<[2,2],f32>) -> !torch.vtensor<[2],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %false = torch.constant.bool false
    %0 = torch.aten.argmin %arg0, %int1, %false : !torch.vtensor<[2,2],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2],si64>
    return %0 : !torch.vtensor<[2],si64>
  }
}

