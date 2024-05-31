

// CHECK-LABEL: func.func @test_slice
func.func @test_slice(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[2],si64>, %arg2: !torch.vtensor<[2],si64>, %arg3: !torch.vtensor<[2],si64>, %arg4: !torch.vtensor<[2],si64>) -> !torch.vtensor<[3,10,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  //CHECK: %[[INDEX_TO_GRAB:.*]] = torch.constant.int 0

  //CHECK: %[[CONST_0:.*]] = torch.constant.int 0
  //CHECK: %[[ZERO_INDEX_VEC:.*]] = torch.prim.NumToTensor.Scalar %[[CONST_0:.*]] : !torch.int -> !torch.vtensor<[1],si64>
  //CHECK: %[[STARTS_INDEX_VEC_0:.*]] = torch.aten.index_select %arg1, %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[STARTS_ELEMENT_0:.*]] = torch.aten.item %[[STARTS_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[ENDS_INDEX_VEC_0:.*]] = torch.aten.index_select %arg2, %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[ENDS_ELEMENT_0:.*]] = torch.aten.item %[[ENDS_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[AXES_INDEX_VEC_0:.*]] = torch.aten.index_select %arg3, %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[AXES_ELEMENT_0:.*]] = torch.aten.item %[[AXES_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[STEPS_INDEX_VEC_0:.*]] = torch.aten.index_select %arg4, %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[STEPS_ELEMENT_0:.*]] = torch.aten.item %[[STEPS_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[SLICE_0:.*]] = torch.aten.slice.Tensor %arg0, %[[AXES_ELEMENT_0:.*]], %[[STARTS_ELEMENT_0:.*]], %[[ENDS_ELEMENT_0:.*]], %[[STEPS_ELEMENT_0:.*]] : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[?,10,5],f32>

  //CHECK: %[[CONST_1:.*]] = torch.constant.int 1
  //CHECK: %[[ONE_INDEX_VEC:.*]] = torch.prim.NumToTensor.Scalar %[[CONST_1:.*]] : !torch.int -> !torch.vtensor<[1],si64>
  //CHECK: %[[STARTS_INDEX_VEC_1:.*]] = torch.aten.index_select %arg1, %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[STARTS_ELEMENT_1:.*]] = torch.aten.item %[[STARTS_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[ENDS_INDEX_VEC_1:.*]] = torch.aten.index_select %arg2, %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[ENDS_ELEMENT_1:.*]] = torch.aten.item %[[ENDS_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[AXES_INDEX_VEC_1:.*]] = torch.aten.index_select %arg3, %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[AXES_ELEMENT_2:.*]] = torch.aten.item %[[AXES_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: %[[STEPS_INDEX_VEC_1:.*]] = torch.aten.index_select %arg4, %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
  //CHECK: %[[STEPS_ELEMENT_1:.*]] = torch.aten.item %[[STEPS_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
  //CHECK: torch.aten.slice.Tensor %[[SLICE_0:.*]], %[[AXES_ELEMENT_1:.*]], %[[STARTS_ELEMENT_1:.*]], %[[ENDS_ELEMENT_1:.*]], %[[STEPS_ELEMENT_1:.*]] : !torch.vtensor<[?,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,10,5],f32>
  %0 = torch.operator "onnx.Slice"(%arg0, %arg1, %arg2, %arg3, %arg4) : (!torch.vtensor<[20,10,5],f32>, !torch.vtensor<[2],si64>, !torch.vtensor<[2],si64>, !torch.vtensor<[2],si64>, !torch.vtensor<[2],si64>) -> !torch.vtensor<[3,10,5],f32>
  return %0 : !torch.vtensor<[3,10,5],f32>
}

