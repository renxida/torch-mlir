module {
  func.func @test_hardsigmoid_default(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int6 = torch.constant.int 6
    %1 = torch.vtensor.literal(dense<1> : tensor<si64>) : !torch.vtensor<[],si64>
    %float2.000000e-01 = torch.constant.float 0.20000000298023224
    %float5.000000e-01 = torch.constant.float 5.000000e-01
    %2 = torch.aten.add.Scalar %arg0, %float5.000000e-01, %float2.000000e-01 : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.float -> !torch.vtensor<[3,4,5],f32>
    %3 = torch.aten.to.dtype %1, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %4 = torch.aten.minimum %3, %2 : !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %5 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %6 = torch.aten.maximum %5, %4 : !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    return %6 : !torch.vtensor<[3,4,5],f32>
  }
}

