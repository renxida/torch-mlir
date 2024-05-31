

// CHECK-LABEL: func.func @test_reduce_prod_keepdims_random
func.func @test_reduce_prod_keepdims_random(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
// CHECK: %[[INT0:.*]] = torch.constant.int 0
// CHECK: %[[INT0_0:.*]] = torch.constant.int 0
// CHECK: %[[SELECT:.*]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT0_0]] : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
// CHECK: %[[ITEM:.*]] = torch.aten.item %[[SELECT]] : !torch.vtensor<[1],si64> -> !torch.int
// CHECK: %[[DIM:.*]] = torch.aten.dim %arg0 : !torch.vtensor<[3,2,2],f32> -> !torch.int
// CHECK: %[[LT:.*]] = torch.aten.lt.int %[[ITEM]], %[[INT0]] : !torch.int, !torch.int -> !torch.bool
// CHECK: %[[BOOL:.*]] = torch.aten.Int.bool %[[LT]] : !torch.bool -> !torch.int
// CHECK: %[[MUL:.*]] = torch.aten.mul.int %[[BOOL]], %[[DIM]] : !torch.int, !torch.int -> !torch.int
// CHECK: %[[ADD:.*]] = torch.aten.add.int %[[ITEM]], %[[MUL]] : !torch.int, !torch.int -> !torch.int
// CHECK: %[[BOOL:.*]] = torch.constant.bool true
// CHECK: %[[NONE:.*]] = torch.constant.none
// CHECK: %[[PROD:.*]] = torch.aten.prod.dim_int %arg0, %[[ADD]], %[[BOOL]], %[[NONE]] : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[3,1,2],f32>
// CHECK: return %[[PROD]] : !torch.vtensor<[3,1,2],f32>
  %0 = torch.operator "onnx.ReduceProd"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,2],f32>
  return %0 : !torch.vtensor<[3,1,2],f32>
}

