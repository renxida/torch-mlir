module {
  func.func @test_leaky_relu(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.opset_version = 16 : si64} {
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %int6 = torch.constant.int 6
    %false = torch.constant.bool false
    %none = torch.constant.none
    %1 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %2 = torch.aten.maximum %1, %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %3 = torch.aten.minimum %1, %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %4 = torch.aten.mul.Scalar %3, %float2.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.float -> !torch.vtensor<[3,4,5],f32>
    %5 = torch.aten.add.Tensor %2, %4, %float1.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32>, !torch.float -> !torch.vtensor<[3,4,5],f32>
    return %5 : !torch.vtensor<[3,4,5],f32>
  }
}

