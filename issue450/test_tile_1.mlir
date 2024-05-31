

// CHECK-LABEL: func.func @test_tile
func.func @test_tile(%arg0: !torch.vtensor<[2, 3, 4],f32>, %arg1: !torch.vtensor<[3], si64>) -> !torch.vtensor<[2,12,4],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT0_0:.*]] = torch.constant.int 0
  // CHECK: %[[EXTRACT_0:.*]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT0_0]] : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[ELE_0:.*]] = torch.aten.item %[[EXTRACT_0]] : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[EXTRACT_1:.*]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT1]] : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[ELE_1:.*]] = torch.aten.item %[[EXTRACT_1]] : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: %[[INT2:.*]] = torch.constant.int 2
  // CHECK: %[[EXTRACT_2:.*]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT2]] : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[ELE_2:.*]] = torch.aten.item %[[EXTRACT_2]] : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: %[[DIM_LIST:.*]] = torch.prim.ListConstruct %[[ELE_0]], %[[ELE_1]], %[[ELE_2]] : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %7 = torch.aten.tile %arg0, %[[DIM_LIST]] : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,12,4],f32>
  %0 = torch.operator "onnx.Tile"(%arg0, %arg1) : (!torch.vtensor<[2, 3, 4],f32>, !torch.vtensor<[3], si64>) -> !torch.vtensor<[2, 12, 4],f32>
  return %0 : !torch.vtensor<[2, 12, 4],f32>
}

