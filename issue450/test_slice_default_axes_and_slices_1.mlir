

// CHECK-LABEL: func.func @test_slice_default_axes_and_slices
func.func @test_slice_default_axes_and_slices(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[3],si64>, %arg2: !torch.vtensor<[3],si64>) -> !torch.vtensor<[20,10,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    //CHECK: %[[NONE_1:.*]] = torch.constant.none
    //CHECK: %[[AXES_DEFAULT_SIZE:.*]] = torch.constant.int 3
    //CHECK: %[[DEFAULT_SIZE_INPUT:.*]] = torch.prim.ListConstruct %[[DEFAULT_SIZE_AMOUNT:.*]] : (!torch.int) -> !torch.list<int>
    //CHECK: %[[DEFAULT_SIZES:.*]] = torch.aten.ones %[[DEFAULT_SIZE_INPUT:.*]], %[[NONE_2:.*]], %[[NONE_2:.*]], %[[NONE_2:.*]], %[[NONE_2:.*]] : !torch.list<int>, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3],si64>
    //CHECK: %[[INDEX_TO_GRAB:.*]] = torch.constant.int 0

    //CHECK: %[[CONST_0:.*]] = torch.constant.int 0
    //CHECK: %[[ZERO_INDEX_VEC:.*]] = torch.prim.NumToTensor.Scalar %[[CONST_0:.*]] : !torch.int -> !torch.vtensor<[1],si64>
    //CHECK: %[[STARTS_INDEX_VEC_0:.*]] = torch.aten.index_select %arg1, %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[STARTS_ELEMENT_0:.*]] = torch.aten.item %[[STARTS_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[ENDS_INDEX_VEC_0:.*]] = torch.aten.index_select %arg2, %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[ENDS_ELEMENT_0:.*]] = torch.aten.item %[[ENDS_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[STEPS_INDEX_VEC_0:.*]] = torch.aten.index_select %[[DEFAULT_SIZES:.*]], %[[INDEX_TO_GRAB:.*]], %[[ZERO_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[STEPS_ELEMENT_0:.*]] = torch.aten.item %[[STEPS_INDEX_VEC_0:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[SLICE_0:.*]] = torch.aten.slice.Tensor %arg0, %[[CONST_0:.*]], %[[STARTS_ELEMENT_0:.*]], %[[ENDS_ELEMENT_0:.*]], %[[STEPS_ELEMENT_0:.*]] : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,?],f32>

    //CHECK: %[[CONST_1:.*]] = torch.constant.int 1
    //CHECK: %[[ONE_INDEX_VEC:.*]] = torch.prim.NumToTensor.Scalar %[[CONST_1:.*]] : !torch.int -> !torch.vtensor<[1],si64>
    //CHECK: %[[STARTS_INDEX_VEC_1:.*]] = torch.aten.index_select %arg1, %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[STARTS_ELEMENT_1:.*]] = torch.aten.item %[[STARTS_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[ENDS_INDEX_VEC_1:.*]] = torch.aten.index_select %arg2, %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[ENDS_ELEMENT_1:.*]] = torch.aten.item %[[ENDS_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[STEPS_INDEX_VEC_1:.*]] = torch.aten.index_select %[[DEFAULT_SIZES:.*]], %[[INDEX_TO_GRAB:.*]], %[[ONE_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[STEPS_ELEMENT_1:.*]] = torch.aten.item %[[STEPS_INDEX_VEC_1:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[TWO_INDEX_VEC:.*]] = torch.aten.slice.Tensor %[[SLICE_0:.*]], %[[CONST_1:.*]], %[[STARTS_ELEMENT_1:.*]], %[[ENDS_ELEMENT_1:.*]], %[[STEPS_ELEMENT_1:.*]] : !torch.vtensor<[20,10,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,?],f32>

    //CHECK: %[[CONST_2:.*]] = torch.constant.int 2
    //CHECK: %[[TWO_INDEX_VEC:.*]] = torch.prim.NumToTensor.Scalar %[[CONST_2:.*]] : !torch.int -> !torch.vtensor<[1],si64>
    //CHECK: %[[STARTS_INDEX_VEC_2:.*]] = torch.aten.index_select %arg1, %[[INDEX_TO_GRAB:.*]], %[[TWO_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[STARTS_ELEMENT_2:.*]] = torch.aten.item %[[STARTS_INDEX_VEC_2:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[ENDS_INDEX_VEC_2:.*]] = torch.aten.index_select %arg2, %[[INDEX_TO_GRAB:.*]], %[[TWO_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[ENDS_ELEMENT_2:.*]] = torch.aten.item %[[ENDS_INDEX_VEC_2:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: %[[STEPS_INDEX_VEC_2:.*]] = torch.aten.index_select %[[DEFAULT_SIZES:.*]], %[[INDEX_TO_GRAB:.*]], %[[TWO_INDEX_VEC:.*]] : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    //CHECK: %[[STEPS_ELEMENT_2:.*]] = torch.aten.item %[[STEPS_INDEX_VEC_2:.*]] : !torch.vtensor<[1],si64> -> !torch.int
    //CHECK: torch.aten.slice.Tensor %[[TWO_INDEX_VEC:.*]], %[[CONST_2:.*]], %[[STARTS_ELEMENT_2:.*]], %[[ENDS_ELEMENT_2:.*]], %[[STEPS_ELEMENT_2:.*]] : !torch.vtensor<[20,10,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,1],f32>
  %0 = torch.operator "onnx.Slice"(%arg0, %arg1, %arg2) : (!torch.vtensor<[20,10,5],f32>, !torch.vtensor<[3],si64>, !torch.vtensor<[3],si64>) -> !torch.vtensor<[20,10,1],f32>
  return %0 : !torch.vtensor<[20,10,1],f32>
}

