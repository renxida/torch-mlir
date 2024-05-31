module {
  func.func @test_size(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[],si32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 9 : si64} {
    %0 = torch.vtensor.literal(dense<60> : tensor<si32>) : !torch.vtensor<[],si32>
    return %0 : !torch.vtensor<[],si32>
  }
}

