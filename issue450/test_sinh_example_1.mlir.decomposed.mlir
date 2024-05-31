module {
  func.func @test_sinh_example(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 4 : si64, torch.onnx_meta.opset_version = 9 : si64} {
    %0 = torch.aten.sinh %arg0 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    return %0 : !torch.vtensor<[3],f32>
  }
}

