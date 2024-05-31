

module {
  func.func @test_clip_attrs(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64} {
    %none = torch.constant.none

    // CHECK: %[[MIN:.+]]  = torch.vtensor.literal(dense<-5.000000e-01> : tensor<3x4xf32>) : !torch.vtensor<[3,4],f32>
    // CHECK: %[[MAX:.+]] = torch.vtensor.literal(dense<5.000000e-01> : tensor<3x4xf32>) : !torch.vtensor<[3,4],f32>
    // CHECK: %[[CLAMP:.+]] = torch.aten.clamp.Tensor %arg0, %[[MIN]], %[[MAX]] : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32> -> !torch.vtensor<[3,4],f32>
    %0 = torch.operator "onnx.Clip"(%arg0) {torch.onnx.max = 5.000000e-01 : f32, torch.onnx.min = -5.000000e-01 : f32} : (!torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32>
    return %0 : !torch.vtensor<[3,4],f32>
  }
}

