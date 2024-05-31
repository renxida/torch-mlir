

// CHECK-LABEL: func.func @test_reduce_l1_do_not_keepdims_example
func.func @test_reduce_l1_do_not_keepdims_example(%arg0:!torch.vtensor<[3,2,2],f32>, %arg1:!torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[ABS:.+]] = torch.aten.abs %arg0 : !torch.vtensor<[3,2,2],f32> -> !torch.vtensor<[3,2,2],f32>
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK: %[[SELECT:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT0_0]] : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[ITEM:.+]] = torch.aten.item %[[SELECT]] : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct %[[ITEM]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: %[[SUM:.+]] = torch.aten.sum.dim_IntList %[[ABS]], %[[DIMS]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
  // CHECK: return %[[SUM]] : !torch.vtensor<[3,2],f32>
  %0 = torch.operator "onnx.ReduceL1"(%arg0, %arg1) {torch.onnx.keepdims = 0 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32>
  return %0 : !torch.vtensor<[3,2],f32>
}

