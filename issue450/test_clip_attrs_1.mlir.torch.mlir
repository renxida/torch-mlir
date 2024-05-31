module {
  func.func @test_clip_attrs(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64} {
    %0 = torch.vtensor.literal(dense<-5.000000e-01> : tensor<3x4xf32>) : !torch.vtensor<[3,4],f32>
    %1 = torch.vtensor.literal(dense<5.000000e-01> : tensor<3x4xf32>) : !torch.vtensor<[3,4],f32>
    %2 = torch.aten.clamp.Tensor %arg0, %0, %1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32> -> !torch.vtensor<[3,4],f32>
    return %2 : !torch.vtensor<[3,4],f32>
  }
}

