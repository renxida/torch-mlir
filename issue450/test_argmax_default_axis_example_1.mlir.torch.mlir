module {
  func.func @test_argmax_default_axis_example(%arg0: !torch.vtensor<[2,2],f32>) -> !torch.vtensor<[1,2],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %true = torch.constant.bool true
    %0 = torch.aten.argmax %arg0, %int0, %true : !torch.vtensor<[2,2],f32>, !torch.int, !torch.bool -> !torch.vtensor<[1,2],si64>
    return %0 : !torch.vtensor<[1,2],si64>
  }
}

