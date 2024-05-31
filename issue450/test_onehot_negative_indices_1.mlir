

// CHECK-LABEL: func.func @test_onehot_negative_indices
func.func @test_onehot_negative_indices(%arg0: !torch.vtensor<[3],si64>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[2],f32>) -> !torch.vtensor<[3,10],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[ITEM:.*]] = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[INT:.*]] = torch.aten.Int.Scalar %[[ITEM]] : !torch.float -> !torch.int
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[C1:.*]]= torch.constant.int 1
  // CHECK: %[[LT:.*]] = torch.aten.lt.Scalar %arg0, %[[C0]] : !torch.vtensor<[3],si64>, !torch.int -> !torch.vtensor<[3],i1>
  // CHECK: %[[ADD:.*]] = torch.aten.add.Scalar %arg0, %[[INT]], %[[C1]]: !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[3],si64>
  // CHECK: %[[WHERE:.*]] = torch.aten.where.self %[[LT]], %[[ADD]], %arg0 : !torch.vtensor<[3],i1>, !torch.vtensor<[3],si64>, !torch.vtensor<[3],si64> -> !torch.vtensor<[3],si64>
  // CHECK: %[[SELECT:.*]] = torch.aten.select.int %arg2, %[[C0]], %[[C0]] : !torch.vtensor<[2],f32>, !torch.int, !torch.int -> !torch.vtensor<[1],f32>
  // CHECK: %[[ITEM_0:.*]] = torch.aten.item %[[SELECT]] : !torch.vtensor<[1],f32> -> !torch.float
  // CHECK: %[[SELECT:.*]] = torch.aten.select.int %arg2, %[[C0]], %[[C1]]: !torch.vtensor<[2],f32>, !torch.int, !torch.int -> !torch.vtensor<[1],f32>
  // CHECK: %[[ITEM_1:.*]] = torch.aten.item %[[SELECT]] : !torch.vtensor<[1],f32> -> !torch.float
  // CHECK: %[[ONEHOT:.*]] = torch.aten.one_hot %[[WHERE]], %[[INT]] : !torch.vtensor<[3],si64>, !torch.int -> !torch.vtensor<[3,?],si32>
  // CHECK: %[[C11:.*]] = torch.constant.int 11
  // CHECK: %[[NONE_0:.*]] = torch.constant.none
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[DTYPE:.*]] = torch.aten.to.dtype %[[ONEHOT]], %[[C11]], %[[FALSE]], %[[FALSE]], %[[NONE_0]] : !torch.vtensor<[3,?],si32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,?],i1>
  // CHECK: %[[RESULT:.*]] = torch.aten.where.Scalar %[[DTYPE]], %[[ITEM_1]], %[[ITEM_0]] : !torch.vtensor<[3,?],i1>, !torch.float, !torch.float -> !torch.vtensor<[3,10],f32>
  // CHECK: return %[[RESULT]] : !torch.vtensor<[3,10],f32>
  %none = torch.constant.none
  %0 = torch.operator "onnx.OneHot"(%arg0, %arg1, %arg2) {torch.onnx.axis = 1 : si64} : (!torch.vtensor<[3],si64>, !torch.vtensor<[],f32>, !torch.vtensor<[2],f32>) -> !torch.vtensor<[3,10],f32>
  return %0 : !torch.vtensor<[3,10],f32>
}

