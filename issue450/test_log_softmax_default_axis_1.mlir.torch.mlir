module {
  func.func @test_log_softmax_default_axis(%arg0: !torch.vtensor<[1,3],f32>) -> !torch.vtensor<[1,3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int-1 = torch.constant.int -1
    %none = torch.constant.none
    %0 = torch.aten.log_softmax.int %arg0, %int-1, %none : !torch.vtensor<[1,3],f32>, !torch.int, !torch.none -> !torch.vtensor<[1,3],f32>
    return %0 : !torch.vtensor<[1,3],f32>
  }
}

