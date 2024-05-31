

// CHECK-LABEL: @test_cast_BFLOAT16_to_FLOAT
func.func @test_cast_BFLOAT16_to_FLOAT(%arg0: !torch.vtensor<[3,4],bf16>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT:.*]] = torch.constant.int 6
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: torch.aten.to.dtype %arg0, %[[INT]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[3,4],bf16>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,4],f32>
  %0 = torch.operator "onnx.Cast"(%arg0) {torch.onnx.to = 1 : si64} : (!torch.vtensor<[3,4],bf16>) -> !torch.vtensor<[3,4],f32>
  return %0 : !torch.vtensor<[3,4],f32>
}

