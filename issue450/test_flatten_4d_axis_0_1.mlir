

// // CHECK-LABEL: @test_flatten_4d_axis_0
func.func @test_flatten_4d_axis_0(%arg0: !torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[1,120],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG: %[[RIGHT_START:.*]] = torch.constant.int 0
  // CHECK-DAG: %[[RIGHT_END:.*]] = torch.constant.int 3
  // CHECK-DAG: %[[CR:.*]] = torch.prims.collapse %arg0, %[[RIGHT_START]], %[[RIGHT_END]] : !torch.vtensor<[2,3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[120],f32>
  // CHECK-DAG: %[[LEFT_INDEX:.*]] = torch.constant.int 0
  // CHECK: torch.aten.unsqueeze %[[CR]], %[[LEFT_INDEX]] : !torch.vtensor<[120],f32>, !torch.int -> !torch.vtensor<[1,120],f32>
  %0 = torch.operator "onnx.Flatten"(%arg0) {torch.onnx.axis = 0 : si64} : (!torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[1,120],f32>
  return %0 : !torch.vtensor<[1,120],f32>
}

