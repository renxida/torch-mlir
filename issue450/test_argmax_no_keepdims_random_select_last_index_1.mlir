

// CHECK-LABEL: @test_argmax_no_keepdims_random_select_last_index
func.func @test_argmax_no_keepdims_random_select_last_index(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,4],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[C1_0:.*]] = torch.constant.int 1
  // CHECK: %[[DIMS:.*]] = torch.prim.ListConstruct %[[C1_0]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[FLIP:.*]] = torch.aten.flip %arg0, %[[DIMS]] : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,3,4],f32>
  // CHECK: %[[ARGMAX:.*]] = torch.aten.argmax %[[FLIP]], %[[C1]], %[[FALSE]] : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2,4],si64>
  // CHECK: %[[C2:.*]] = torch.constant.int 2
  // CHECK: %[[C1_1:.*]] = torch.constant.int 1
  // CHECK: %[[SUB:.*]] = torch.aten.sub.Scalar %[[ARGMAX]], %[[C2]], %[[C1_1]] : !torch.vtensor<[2,4],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,4],si64>
  // CHECK: %[[ABS:.*]] = torch.aten.abs %[[SUB]] : !torch.vtensor<[2,4],si64> -> !torch.vtensor<[2,4],si64>
  %0 = torch.operator "onnx.ArgMax"(%arg0) {torch.onnx.axis = 1 : si64, torch.onnx.keepdims = 0 : si64, torch.onnx.select_last_index = 1 : si64} : (!torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,4],si64>
  return %0 : !torch.vtensor<[2,4],si64>
}

