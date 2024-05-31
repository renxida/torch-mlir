module {
  func.func @test_softplus(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.exp %arg0 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    %1 = torch.aten.log1p %0 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    return %1 : !torch.vtensor<[3],f32>
  }
}

