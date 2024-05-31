module {
  func.func @test_elu_example(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %int6 = torch.constant.int 6
    %false = torch.constant.bool false
    %none = torch.constant.none
    %1 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %2 = torch.aten.maximum %1, %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    %3 = torch.aten.mul.Scalar %2, %float1.000000e00 : !torch.vtensor<[3],f32>, !torch.float -> !torch.vtensor<[3],f32>
    %4 = torch.aten.minimum %1, %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    %5 = torch.aten.mul.Scalar %4, %float1.000000e00 : !torch.vtensor<[3],f32>, !torch.float -> !torch.vtensor<[3],f32>
    %6 = torch.aten.exp %5 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    %7 = torch.aten.sub.Scalar %6, %float1.000000e00, %float1.000000e00 : !torch.vtensor<[3],f32>, !torch.float, !torch.float -> !torch.vtensor<[3],f32>
    %8 = torch.aten.mul.Scalar %7, %float1.000000e00 : !torch.vtensor<[3],f32>, !torch.float -> !torch.vtensor<[3],f32>
    %9 = torch.aten.mul.Scalar %8, %float2.000000e00 : !torch.vtensor<[3],f32>, !torch.float -> !torch.vtensor<[3],f32>
    %10 = torch.aten.add.Tensor %3, %9, %float1.000000e00 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.float -> !torch.vtensor<[3],f32>
    return %10 : !torch.vtensor<[3],f32>
  }
}

