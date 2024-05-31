module {
  func.func @test_dropout_default_ratio(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.FloatImplicit %arg1 : !torch.vtensor<[],f32> -> !torch.float
    return %arg0 : !torch.vtensor<[3,4,5],f32>
  }
}

