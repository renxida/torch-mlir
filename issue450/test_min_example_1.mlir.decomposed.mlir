module {
  func.func @test_min_example(%arg0: !torch.vtensor<[3],f32>, %arg1: !torch.vtensor<[3],f32>, %arg2: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.minimum %arg0, %arg1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    %1 = torch.aten.minimum %0, %arg2 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    return %1 : !torch.vtensor<[3],f32>
  }
}

