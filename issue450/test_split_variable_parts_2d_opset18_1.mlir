

// CHECK-LABEL:   func.func @test_split_variable_parts_2d_opset18(
// CHECK-SAME:                                                    %[[VAL_INPUT:.*]]: !torch.vtensor<[2,6],f32>,
// CHECK-SAME:                                                    %[[VAL_SPLIT:.*]]: !torch.vtensor<[2],si64>
// CHECK:           %[[VAL_SPLIT_LIST:.*]] = torch.prim.tolist(%[[VAL_SPLIT]]) : !torch.vtensor<[2],si64> -> !torch.list<int>
// CHECK:           %[[VAL_AXIS:.*]] = torch.constant.int 1
// CHECK:           %[[VAL_RESULT_LIST:.*]] = torch.aten.split_with_sizes %[[VAL_INPUT]], %[[VAL_SPLIT_LIST]], %[[VAL_AXIS]] : !torch.vtensor<[2,6],f32>, !torch.list<int>, !torch.int -> !torch.list<vtensor<[2,?],f32>>
// CHECK:           %[[VAL_VARIADIC_RETURN_VALUE:.*]]:2 = torch.prim.ListUnpack %[[VAL_RESULT_LIST]] : !torch.list<vtensor<[2,?],f32>> -> !torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>
// CHECK:           return %[[VAL_VARIADIC_RETURN_VALUE]]#0, %[[VAL_VARIADIC_RETURN_VALUE]]#1 : !torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>
func.func @test_split_variable_parts_2d_opset18(%arg0: !torch.vtensor<[2,6],f32>, %arg1: !torch.vtensor<[2],si64>) -> (!torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>) attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  %0:2 = torch.operator "onnx.Split"(%arg0, %arg1) {torch.onnx.axis = 1 : si64} : (!torch.vtensor<[2,6],f32>, !torch.vtensor<[2],si64>) -> (!torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>)
  return %0#0, %0#1 : !torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>
}

