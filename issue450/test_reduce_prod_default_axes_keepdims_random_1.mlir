

// CHECK-LABEL: func.func @test_reduce_prod_default_axes_keepdims_random
func.func @test_reduce_prod_default_axes_keepdims_random(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[1,1,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT0_0:.*]] = torch.constant.int 0
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[INT2:.*]] = torch.constant.int 2
  // CHECK: %[[RANK:.*]] = torch.aten.dim %arg0 : !torch.vtensor<[3,2,2],f32> -> !torch.int
  // CHECK: %[[LT:.*]] = torch.aten.lt.int %[[INT0_0]], %[[INT0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL:.*]] = torch.aten.Int.bool %[[LT]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL:.*]] = torch.aten.mul.int %[[BOOL]], %[[RANK]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[ADD:.*]] = torch.aten.add.int %[[INT0_0]], %[[MUL]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LT_0:.*]] = torch.aten.lt.int %[[INT1]], %[[INT0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL_0:.*]] = torch.aten.Int.bool %[[LT_0]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL_0:.*]] = torch.aten.mul.int %[[BOOL_0]], %[[RANK]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[ADD_0:.*]] = torch.aten.add.int %[[INT1]], %[[MUL_0]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LT_1:.*]] = torch.aten.lt.int %[[INT2]], %[[INT0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL_1:.*]] = torch.aten.Int.bool %[[LT_1]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL_1:.*]] = torch.aten.mul.int %[[BOOL_1]], %[[RANK]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[ADD_1:.*]] = torch.aten.add.int %[[INT2]], %[[MUL_1]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[TRUE:.*]] = torch.constant.bool true
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[PROD_0:.*]] = torch.aten.prod.dim_int %arg0, %[[ADD]], %[[TRUE]], %[[NONE]] : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[?,?,?],f32>
  // CHECK: %[[PROD_1:.*]] = torch.aten.prod.dim_int %[[PROD_0]], %[[ADD_0]], %[[TRUE]], %[[NONE]] : !torch.vtensor<[?,?,?],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[?,?,?],f32>
  // CHECK: %[[PROD_2:.*]] = torch.aten.prod.dim_int %[[PROD_1]], %[[ADD_1]], %[[TRUE]], %[[NONE]] : !torch.vtensor<[?,?,?],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f32>
  // CHECK: return %[[PROD_2]] : !torch.vtensor<[1,1,1],f32>
  %0 = torch.operator "onnx.ReduceProd"(%arg0) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[1,1,1],f32>
  return %0 : !torch.vtensor<[1,1,1],f32>
}

