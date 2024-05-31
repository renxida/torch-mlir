module {
  func.func @test_hardmax(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int6 = torch.constant.int 6
    %false = torch.constant.bool false
    %0 = torch.aten.argmax %arg0, %int6, %false : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.bool -> !torch.vtensor<[3,4,5],f32>
    %1 = torch.aten.one_hot %0, %int1 : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,4,5],f32>
    return %1 : !torch.vtensor<[3,4,5],f32>
  }
}

