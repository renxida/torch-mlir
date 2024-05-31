

// CHECK-LABEL: func.func @test_constant_of_shape_dense_int_cst
func.func @test_constant_of_shape_dense_int_cst() -> !torch.vtensor<[2,3,4], si64> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[SHAPE_CST:.*]] = torch.vtensor.literal(dense<[2, 3, 4]> : tensor<3xsi64>) : !torch.vtensor<[3],si64>
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT0_0:.*]] = torch.constant.int 0
  // CHECK: %[[EXTRACT_0:.*]] = torch.aten.select.int %[[SHAPE_CST]], %[[INT0]], %[[INT0_0]] : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ELE_0:.*]] = torch.aten.item %[[EXTRACT_0]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[EXTRACT_1:.*]] = torch.aten.select.int %[[SHAPE_CST]], %[[INT0]], %[[INT1]] : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ELE_1:.*]] = torch.aten.item %[[EXTRACT_1]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[INT2:.*]]  = torch.constant.int 2
  // CHECK: %[[EXTRACT_2:.*]] = torch.aten.select.int %[[SHAPE_CST]], %[[INT0]], %[[INT2]] : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ELE_2:.*]] = torch.aten.item %[[EXTRACT_2]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[DIM_LIST:.*]] = torch.prim.ListConstruct %[[ELE_0]], %[[ELE_1]], %[[ELE_2]] : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[FILL_VAL:.*]] = torch.constant.int 3
  // CHECK: %[[ATEN_FULL:.*]] = torch.aten.full %[[DIM_LIST]], %[[FILL_VAL]], %[[NONE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2,3,4],si64>
  %cst = torch.vtensor.literal(dense<[2,3,4]> : tensor<3xsi64>) : !torch.vtensor<[3], si64>
  %0 = "torch.operator"(%cst) <{name = "onnx.ConstantOfShape"}> {torch.onnx.value = dense<3> : tensor<1xsi64>}: (!torch.vtensor<[3], si64>) -> !torch.vtensor<[2,3,4], si64>
  return %0 : !torch.vtensor<[2,3,4], si64>
}

