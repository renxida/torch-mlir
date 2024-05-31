

// CHECK-LABEL: @test_slice_default_axes_and_steps
// CHECK-SAME:    %[[ARG0:.*]]: !torch.vtensor<[20,10,5],f32>,
// CHECK-SAME:    %[[ARG1:.*]]: !torch.vtensor<[1],si64>,
// CHECK-SAME:    %[[ARG2:.*]]: !torch.vtensor<[1],si64>

// CHECK: %[[ZERO0:.*]] = torch.constant.int 0
// CHECK-NEXT: %[[ZERO1:.*]] = torch.constant.int 0
// CHECK-NEXT: %[[SCALAR:.*]] = torch.prim.NumToTensor.Scalar %[[ZERO1]] : !torch.int -> !torch.vtensor<[1],si64>
// CHECK-NEXT: %[[SELECT0:.*]] = torch.aten.index_select %[[ARG1]], %[[ZERO0]], %[[SCALAR]] : !torch.vtensor<[1],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
// CHECK-NEXT: %[[ITEM0:.*]] = torch.aten.item %[[SELECT0]] : !torch.vtensor<[1],si64> -> !torch.int
// CHECK-NEXT: %[[SELECT1:.*]] = torch.aten.index_select %[[ARG2]], %[[ZERO0]], %[[SCALAR]] : !torch.vtensor<[1],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
// CHECK-NEXT: %[[ITEM1:.*]] = torch.aten.item %[[SELECT1]] : !torch.vtensor<[1],si64> -> !torch.int
// CHECK-NEXT: %[[SELECT3:.*]] = torch.aten.index_select %{{.*}}, %[[ZERO0]], %[[SCALAR]] : !torch.vtensor<[1],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
// CHECK-NEXT: %[[ITEM3:.*]] = torch.aten.item %[[SELECT3]] : !torch.vtensor<[1],si64> -> !torch.int
// CHECK: torch.aten.slice.Tensor %[[ARG0]], %[[ZERO1]], %[[ITEM0]], %[[ITEM1]], %[[ITEM3]] : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,1],f32>

func.func @test_slice_default_axes_and_steps(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[1],si64>, %arg2: !torch.vtensor<[1],si64>) -> !torch.vtensor<[20,10,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
  %0 = torch.operator "onnx.Slice"(%arg0, %arg1, %arg2) : (!torch.vtensor<[20,10,5],f32>, !torch.vtensor<[1],si64>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[20,10,1],f32>
  return %0 : !torch.vtensor<[20,10,1],f32>
}

