module {
  func.func @test_leaky_relu(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.opset_version = 16 : si64} {
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %0 = torch.aten.leaky_relu %arg0, %float2.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.float -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }
}

