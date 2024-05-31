

// CHECK-LABEL: func.func @test_pad
func.func @test_pad(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[4], si64>, %arg2: !torch.vtensor<[], f32>) -> !torch.vtensor<[5,4],f32> attributes {torch.onnx_meta.opset_version = 19 : si64} {
  // CHECK: %[[VAL:.+]] = torch.aten.item %arg2 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK: %[[SELECT_0:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT0_0]] : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ITEM_0:.+]] = torch.aten.item %[[SELECT_0]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[INT1:.+]] = torch.constant.int 1
  // CHECK: %[[SELECT_1:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT1]] : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ITEM_1:.+]] = torch.aten.item %[[SELECT_1]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[INT2:.+]] = torch.constant.int 2
  // CHECK: %[[SELECT_2:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT2]] : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ITEM_2:.+]] = torch.aten.item %[[SELECT_2]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[INT3:.+]] = torch.constant.int 3
  // CHECK: %[[SELECT_3:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT3]] : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
  // CHECK: %[[ITEM_3:.+]] = torch.aten.item %[[SELECT_3]] : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: %[[LIST:.+]] = torch.prim.ListConstruct %[[ITEM_0]], %[[ITEM_2]], %[[ITEM_1]], %[[ITEM_3]] : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[STR:.+]] = torch.constant.str "constant"
  // CHECK: %[[PAD:.+]] = torch.aten.pad %arg0, %[[LIST]], %[[STR]], %[[VAL]] : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.str, !torch.float -> !torch.vtensor<[5,4],f32>
  // CHECK: return %[[PAD]] : !torch.vtensor<[5,4],f32>
  %0 = torch.operator "onnx.Pad"(%arg0, %arg1, %arg2) {torch.onnx.mode = "constant"} : (!torch.vtensor<[3,4],f32>, !torch.vtensor<[4], si64>, !torch.vtensor<[], f32>) -> !torch.vtensor<[5,4],f32>
  return %0 : !torch.vtensor<[5,4],f32>
}

