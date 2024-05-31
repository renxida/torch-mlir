module {
  func.func @test_random_uniform_like(%arg0: !torch.vtensor<[10],f32>) -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %none = torch.constant.none
    %0 = torch.aten.uniform %arg0, %float0.000000e00, %float1.000000e00, %none : !torch.vtensor<[10],f32>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f32>
    return %0 : !torch.vtensor<[10],f32>
  }
}

