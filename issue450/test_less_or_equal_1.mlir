

// CHECK-LABEL: func.func @test_less_or_equal
func.func @test_less_or_equal(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],i1> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 16 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-SAME: %[[ARG0:[a-zA-Z0-9]+]]: !torch.vtensor<[3,4,5],f32>
  // CHECK-SAME: %[[ARG1:[a-zA-Z0-9]+]]: !torch.vtensor<[3,4,5],f32>
  // CHECK: torch.aten.le.Tensor %[[ARG0]], %[[ARG1]] : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],i1>
  %0 = torch.operator "onnx.LessOrEqual"(%arg0, %arg1) : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],i1>
  return %0 : !torch.vtensor<[3,4,5],i1>
}

