

// CHECK-LABEL: @test_argmin_no_keepdims_example_select_last_index
func.func @test_argmin_no_keepdims_example_select_last_index(%arg0: !torch.vtensor<[2,2],f32>) -> !torch.vtensor<[2],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[C1_0:.*]] = torch.constant.int 1
  // CHECK: %[[DIMS:.*]] = torch.prim.ListConstruct %[[C1_0]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[FLIP:.*]] = torch.aten.flip %arg0, %[[DIMS]] : !torch.vtensor<[2,2],f32>, !torch.list<int> -> !torch.vtensor<[2,2],f32>
  // CHECK: %[[ARGMIN:.*]] = torch.aten.argmin %[[FLIP]], %[[C1]], %[[FALSE]] : !torch.vtensor<[2,2],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2],si64>
  // CHECK: %[[C1_1:.*]] = torch.constant.int 1
  // CHECK: %[[C1_2:.*]] = torch.constant.int 1
  // CHECK: %[[SUB:.*]] = torch.aten.sub.Scalar %[[ARGMIN]], %[[C1_1]], %[[C1_2]] : !torch.vtensor<[2],si64>, !torch.int, !torch.int -> !torch.vtensor<[2],si64>
  // CHECK: %[[ABS:.*]] = torch.aten.abs %[[SUB]] : !torch.vtensor<[2],si64> -> !torch.vtensor<[2],si64>
  %0 = torch.operator "onnx.ArgMin"(%arg0) {torch.onnx.axis = 1 : si64, torch.onnx.keepdims = 0 : si64, torch.onnx.select_last_index = 1 : si64} : (!torch.vtensor<[2,2],f32>) -> !torch.vtensor<[2],si64>
  return %0 : !torch.vtensor<[2],si64>
}

