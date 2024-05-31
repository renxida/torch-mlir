module {
  func.func @test_unsqueeze_axis_1(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.aten.unsqueeze %arg0, %int1 : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,1,4,5],f32>
    return %0 : !torch.vtensor<[3,1,4,5],f32>
  }
}

