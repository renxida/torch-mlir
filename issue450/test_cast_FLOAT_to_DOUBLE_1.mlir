

// CHECK-LABEL: @test_cast_FLOAT_to_DOUBLE
func.func @test_cast_FLOAT_to_DOUBLE(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f64> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT:.*]] = torch.constant.int 7
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: torch.aten.to.dtype %arg0, %[[INT]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[3,4],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,4],f64>
  %0 = torch.operator "onnx.Cast"(%arg0) {torch.onnx.to = 11 : si64} : (!torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f64>
  return %0 : !torch.vtensor<[3,4],f64>
}

