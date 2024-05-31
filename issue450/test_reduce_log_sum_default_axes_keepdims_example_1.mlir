

// CHECK-LABEL: func.func @test_reduce_log_sum_default_axes_keepdims_example
func.func @test_reduce_log_sum_default_axes_keepdims_example(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[0],si64>) -> !torch.vtensor<[1,1,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct  : () -> !torch.list<int>
  // CHECK: %[[TRUE:.+]] = torch.constant.bool true
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: %[[SUM:.+]] = torch.aten.sum.dim_IntList %arg0, %[[DIMS]], %[[TRUE]], %[[NONE]] : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f32>
  // CHECK: %[[LOG:.+]] = torch.aten.log %[[SUM]] : !torch.vtensor<[1,1,1],f32> -> !torch.vtensor<[1,1,1],f32>
  // CHECK: return %[[LOG]] : !torch.vtensor<[1,1,1],f32>
  %0 = torch.operator "onnx.ReduceLogSum"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[0],si64>) -> !torch.vtensor<[1,1,1],f32>
  return %0 : !torch.vtensor<[1,1,1],f32>
}

