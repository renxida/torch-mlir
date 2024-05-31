

// CHECK-LABEL: func.func @test_reduce_l2_keep_dims_example
func.func @test_reduce_l2_keep_dims_example(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[MULT:.+]] = torch.aten.mul.Tensor %arg0, %arg0 : !torch.vtensor<[3,2,2],f32>, !torch.vtensor<[3,2,2],f32> -> !torch.vtensor<[3,2,2],f32>
  // CHECK: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK: %[[INT0_1:.+]] = torch.constant.int 0
  // CHECK: %[[SELECT:.+]] = torch.aten.select.int %arg1, %[[INT0_0]], %[[INT0_1]] : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[ITEM:.+]] = torch.aten.item %[[SELECT]] : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct %[[ITEM]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[TRUE:.+]] = torch.constant.bool true
  // CHECK: %[[NONE_0:.+]] = torch.constant.none
  // CHECK: %[[SUM:.+]] = torch.aten.sum.dim_IntList %[[MULT]], %[[DIMS]], %[[TRUE]], %[[NONE_0]] : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2,1],f32>
  // CHECK: %[[INT6_0:.+]] = torch.constant.int 6
  // CHECK: %[[NONE_1:.+]] = torch.constant.none
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[CAST:.+]] = torch.aten.to.dtype %[[SUM]], %[[INT6_0]], %[[FALSE]], %[[FALSE]], %[[NONE_1]] : !torch.vtensor<[3,2,1],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,2,1],f32>
  // CHECK: %[[SQRT:.+]] = torch.aten.sqrt %[[CAST]] : !torch.vtensor<[3,2,1],f32> -> !torch.vtensor<[3,2,1],f32>
  // CHECK: %[[INT6_1:.+]] = torch.constant.int 6
  // CHECK: %[[CASTLIKE:.+]] = torch.aten.to.dtype %[[SQRT]], %[[INT6_1]], %[[FALSE]], %[[FALSE]], %[[NONE_1]] : !torch.vtensor<[3,2,1],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,2,1],f32>
  // CHECK: return %[[CASTLIKE]] : !torch.vtensor<[3,2,1],f32>

  %0 = torch.operator "onnx.ReduceL2"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2,1],f32>
  return %0 : !torch.vtensor<[3,2,1],f32>
}

