module {
  func.func @test_squeeze_no_axes(%arg0: !torch.vtensor<[1,3,1,4,1,5,1,1],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.squeeze %arg0 : !torch.vtensor<[1,3,1,4,1,5,1,1],f32> -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }
}

