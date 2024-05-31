module {
  func.func @test_celu(%arg0: !torch.vtensor<[3,3,3,1],f32>) -> !torch.vtensor<[3,3,3,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int6 = torch.constant.int 6
    %0 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %int1 = torch.constant.int 1
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %1 = torch.aten.div.Scalar %arg0, %float2.000000e00 : !torch.vtensor<[3,3,3,1],f32>, !torch.float -> !torch.vtensor<[3,3,3,1],f32>
    %2 = torch.aten.exp %1 : !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
    %3 = torch.aten.sub.Scalar %2, %int1, %int1 : !torch.vtensor<[3,3,3,1],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,3,3,1],f32>
    %4 = torch.aten.mul.Scalar %3, %float2.000000e00 : !torch.vtensor<[3,3,3,1],f32>, !torch.float -> !torch.vtensor<[3,3,3,1],f32>
    %5 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %6 = torch.aten.minimum %5, %4 : !torch.vtensor<[],f32>, !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
    %7 = torch.aten.maximum %5, %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
    %8 = torch.aten.add.Tensor %7, %6, %int1 : !torch.vtensor<[3,3,3,1],f32>, !torch.vtensor<[3,3,3,1],f32>, !torch.int -> !torch.vtensor<[3,3,3,1],f32>
    return %8 : !torch.vtensor<[3,3,3,1],f32>
  }
}

