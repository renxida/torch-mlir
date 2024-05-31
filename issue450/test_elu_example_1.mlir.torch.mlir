module {
  func.func @test_elu_example(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.aten.elu %arg0, %float2.000000e00, %float1.000000e00, %float1.000000e00 : !torch.vtensor<[3],f32>, !torch.float, !torch.float, !torch.float -> !torch.vtensor<[3],f32>
    return %0 : !torch.vtensor<[3],f32>
  }
}

