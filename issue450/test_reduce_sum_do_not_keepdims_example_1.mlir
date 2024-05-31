

// CHECK-LABEL: func.func @test_reduce_sum_do_not_keepdims_example
func.func @test_reduce_sum_do_not_keepdims_example(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK: %[[SELECT:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT0_0]] : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[DIM:.+]] = torch.aten.item %[[SELECT]] : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct %1 : (!torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: torch.aten.sum.dim_IntList %arg0, %[[DIMS]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
  %0 = torch.operator "onnx.ReduceSum"(%arg0, %arg1) {torch.onnx.keepdims = 0 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32>
  return %0 : !torch.vtensor<[3,2],f32>
}

