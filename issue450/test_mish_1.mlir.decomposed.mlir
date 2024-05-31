module {
  func.func @test_mish(%arg0: !torch.vtensor<[10000],f32>) -> !torch.vtensor<[10000],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %float2.000000e01 = torch.constant.float 2.000000e+01
    %0 = torch.aten.mul.Scalar %arg0, %float1.000000e00 : !torch.vtensor<[10000],f32>, !torch.float -> !torch.vtensor<[10000],f32>
    %1 = torch.aten.exp %0 : !torch.vtensor<[10000],f32> -> !torch.vtensor<[10000],f32>
    %2 = torch.aten.log1p %1 : !torch.vtensor<[10000],f32> -> !torch.vtensor<[10000],f32>
    %3 = torch.aten.div.Scalar %2, %float1.000000e00 : !torch.vtensor<[10000],f32>, !torch.float -> !torch.vtensor<[10000],f32>
    %4 = torch.aten.gt.Scalar %0, %float2.000000e01 : !torch.vtensor<[10000],f32>, !torch.float -> !torch.vtensor<[10000],i1>
    %5 = torch.aten.where.self %4, %arg0, %3 : !torch.vtensor<[10000],i1>, !torch.vtensor<[10000],f32>, !torch.vtensor<[10000],f32> -> !torch.vtensor<[10000],f32>
    %6 = torch.aten.tanh %5 : !torch.vtensor<[10000],f32> -> !torch.vtensor<[10000],f32>
    %7 = torch.aten.mul.Tensor %arg0, %6 : !torch.vtensor<[10000],f32>, !torch.vtensor<[10000],f32> -> !torch.vtensor<[10000],f32>
    return %7 : !torch.vtensor<[10000],f32>
  }
}

