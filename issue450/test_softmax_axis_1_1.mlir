

// CHECK-LABEL: func.func @test_softmax_axis_1
func.func @test_softmax_axis_1(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: torch.aten.softmax.int %arg0, %int1, %none : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.none -> !torch.vtensor<[3,4,5],f32>
  %0 = torch.operator "onnx.Softmax"(%arg0) {torch.onnx.axis = 1 : si64} : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

