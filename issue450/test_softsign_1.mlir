

// CHECK-LABEL: func.func @test_softsign
func.func @test_softsign(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 10 : si64, torch.onnx_meta.opset_version = 22 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[ABS:.+]] = torch.aten.abs %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[RES:.+]] = torch.aten.add.Scalar %[[ABS]], %[[INT1]], %[[INT1]] : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,4,5],f32>
  // CHECK: %[[SCALE_T:.*]] = torch.aten.div.Tensor %arg0, %[[RES]] : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
  // CHECK: return %[[SCALE_T]] : !torch.vtensor<[3,4,5],f32>
  %none = torch.constant.none
  %0 = torch.operator "onnx.Softsign"(%arg0) : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

