module {
  func.func @test_selu(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.opset_version = 6 : si64} {
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %float3.000000e00 = torch.constant.float 3.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.aten.elu %arg0, %float2.000000e00, %float3.000000e00, %float1.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.float, !torch.float -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }
}

