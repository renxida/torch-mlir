

// CHECK-LABEL: func.func @test_reduce_log_sum_exp_default_axes_keepdims_example
func.func @test_reduce_log_sum_exp_default_axes_keepdims_example(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[0],si64>) -> !torch.vtensor<[1,1,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT7:.+]] = torch.constant.int 7
  // CHECK: %[[NONE_0:.+]] = torch.constant.none
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[CAST:.+]] = torch.aten.to.dtype %arg0, %[[INT7]], %[[FALSE]], %[[FALSE]], %[[NONE_0]] : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,2,2],f64>
  // CHECK: %[[EXP:.+]] = torch.aten.exp %[[CAST]] : !torch.vtensor<[3,2,2],f64> -> !torch.vtensor<[3,2,2],f64>
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct  : () -> !torch.list<int>
  // CHECK: %[[TRUE:.+]] = torch.constant.bool true
  // CHECK: %[[NONE_1:.+]] = torch.constant.none
  // CHECK: %[[SUM:.+]] = torch.aten.sum.dim_IntList %[[EXP]], %[[DIMS]], %[[TRUE]], %[[NONE_1]] : !torch.vtensor<[3,2,2],f64>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f64>
  // CHECK: %[[LOG:.+]] = torch.aten.log %[[SUM]] : !torch.vtensor<[1,1,1],f64> -> !torch.vtensor<[1,1,1],f64>
  // CHECK: %[[INT6:.+]] = torch.constant.int 6
  // CHECK: %[[CASTLIKE:.+]] = torch.aten.to.dtype %[[LOG]], %[[INT6]], %[[FALSE]], %[[FALSE]], %[[NONE_0]] : !torch.vtensor<[1,1,1],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f32>
  // CHECK: return %[[CASTLIKE]] : !torch.vtensor<[1,1,1],f32>
  %0 = torch.operator "onnx.ReduceLogSumExp"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[0],si64>) -> !torch.vtensor<[1,1,1],f32>
  return %0 : !torch.vtensor<[1,1,1],f32>
}

