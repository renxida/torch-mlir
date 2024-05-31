module {
  func.func @test_hardswish(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %0 = torch.vtensor.literal(dense<6> : tensor<si64>) : !torch.vtensor<[],si64>
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %int6 = torch.constant.int 6
    %1 = torch.aten.add.Scalar %arg0, %int3, %int1 : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,4,5],f32>
    %2 = torch.aten.relu %1 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %3 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %4 = torch.aten.minimum %2, %3 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[3,4,5],f32>
    %5 = torch.aten.div.Scalar %4, %int6 : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,4,5],f32>
    %6 = torch.aten.mul.Tensor %5, %arg0 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    return %6 : !torch.vtensor<[3,4,5],f32>
  }
}

