

// CHECK-LABEL: @test_argmin_negative_axis_keepdims_random_select_last_index
func.func @test_argmin_negative_axis_keepdims_random_select_last_index(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,3,1],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C2:.*]] = torch.constant.int 2
  // CHECK: %[[TRUE:.*]] = torch.constant.bool true
  // CHECK: %[[C2_0:.*]] = torch.constant.int 2
  // CHECK: %[[DIMS:.*]] = torch.prim.ListConstruct %[[C2_0]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[FLIP:.*]] = torch.aten.flip %arg0, %[[DIMS]] : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,3,4],f32>
  // CHECK: %[[ARGMIN:.*]] = torch.aten.argmin %[[FLIP]], %[[C2]], %[[TRUE]] : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2,3,1],si64>
  // CHECK: %[[C3:.*]] = torch.constant.int 3
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[SUB:.*]] = torch.aten.sub.Scalar %[[ARGMIN]], %[[C3]], %[[C1]] : !torch.vtensor<[2,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,3,1],si64>
  // CHECK: %[[ABS:.*]] = torch.aten.abs %[[SUB]] : !torch.vtensor<[2,3,1],si64> -> !torch.vtensor<[2,3,1],si64>
  %0 = torch.operator "onnx.ArgMin"(%arg0) {torch.onnx.axis = -1 : si64, torch.onnx.keepdims = 1 : si64, torch.onnx.select_last_index = 1 : si64} : (!torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,3,1],si64>
  return %0 : !torch.vtensor<[2,3,1],si64>
}

