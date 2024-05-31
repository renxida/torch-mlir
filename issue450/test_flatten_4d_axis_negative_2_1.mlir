

// CHECK-LABEL: @test_flatten_4d_axis_negative_2
func.func @test_flatten_4d_axis_negative_2(%arg0: !torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[6,20],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG: %[[RIGHT_START:.*]] = torch.constant.int 2
  // CHECK-DAG: %[[RIGHT_END:.*]] = torch.constant.int 3
  // CHECK-DAG: %[[CR:.*]] = torch.prims.collapse %arg0, %[[RIGHT_START]], %[[RIGHT_END]] : !torch.vtensor<[2,3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[2,3,20],f32>
  // CHECK-DAG: %[[LEFT_START:.*]] = torch.constant.int 0
  // CHECK-DAG: %[[LEFT_END:.*]] = torch.constant.int 1
  // CHECK: torch.prims.collapse %[[CR]], %[[LEFT_START]], %[[LEFT_END]] : !torch.vtensor<[2,3,20],f32>, !torch.int, !torch.int -> !torch.vtensor<[6,20],f32>
  %0 = torch.operator "onnx.Flatten"(%arg0) {torch.onnx.axis = -2 : si64} : (!torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[6,20],f32>
  return %0 : !torch.vtensor<[6,20],f32>
}

