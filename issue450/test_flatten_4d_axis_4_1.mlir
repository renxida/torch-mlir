

// CHECK-LABEL: @test_flatten_4d_axis_4
func.func @test_flatten_4d_axis_4(%arg0: !torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[120,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG: %[[RIGHT_INDEX:.*]] = torch.constant.int 4
  // CHECK-DAG: %[[CR:.*]] = torch.aten.unsqueeze %arg0, %[[RIGHT_INDEX]] : !torch.vtensor<[2,3,4,5],f32>, !torch.int -> !torch.vtensor<[2,3,4,5,1],f32>
  // CHECK-DAG: %[[LEFT_START:.*]] = torch.constant.int 0
  // CHECK-DAG: %[[LEFT_END:.*]] = torch.constant.int 3
  // CHECK: torch.prims.collapse %[[CR]], %[[LEFT_START]], %[[LEFT_END]] : !torch.vtensor<[2,3,4,5,1],f32>, !torch.int, !torch.int -> !torch.vtensor<[120,1],f32>
  %0 = torch.operator "onnx.Flatten"(%arg0) {torch.onnx.axis = 4 : si64} : (!torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[120,1],f32>
  return %0 : !torch.vtensor<[120,1],f32>
}

