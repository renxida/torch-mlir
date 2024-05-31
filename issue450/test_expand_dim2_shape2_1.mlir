

// CHECK-LABEL: @test_expand_dim2_shape2
func.func @test_expand_dim2_shape2(%arg0: !torch.vtensor<[1,4],f32>, %arg1: !torch.vtensor<[2],si32>)
              -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG: %[[INT0:.+]] = torch.constant.int 0
  // CHECK-DAG: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK-DAG: %[[SEL0:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT0_0]] : !torch.vtensor<[2],si32>, !torch.int, !torch.int -> !torch.vtensor<[],si32>
  // CHECK-DAG: %[[ITEM0:.+]] = torch.aten.item %[[SEL0]] : !torch.vtensor<[],si32> -> !torch.int
  // CHECK-DAG: %[[I0:.+]] = torch.constant.int 0
  // CHECK-DAG: %[[SZ0:.+]] = torch.aten.size.int %arg0, %[[I0]] : !torch.vtensor<[1,4],f32>, !torch.int -> !torch.int
  // CHECK-DAG: %[[MX0:.+]] = torch.prim.max.int %[[ITEM0]], %[[SZ0]] : !torch.int, !torch.int -> !torch.int
  // CHECK-DAG: %[[INT1:.+]] = torch.constant.int 1
  // CHECK-DAG: %[[SEL1:.+]] = torch.aten.select.int %arg1, %[[INT0]], %[[INT1]] : !torch.vtensor<[2],si32>, !torch.int, !torch.int -> !torch.vtensor<[],si32>
  // CHECK-DAG: %[[ITEM1:.+]] = torch.aten.item %[[SEL1]] : !torch.vtensor<[],si32> -> !torch.int
  // CHECK-DAG: %[[I1:.+]] = torch.constant.int 1
  // CHECK-DAG: %[[SZ1:.+]] = torch.aten.size.int %arg0, %[[I1]] : !torch.vtensor<[1,4],f32>, !torch.int -> !torch.int
  // CHECK-DAG: %[[MX1:.+]] = torch.prim.max.int %[[ITEM1]], %[[SZ1]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LIST:.+]] = torch.prim.ListConstruct %[[MX0]], %[[MX1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: torch.aten.broadcast_to %arg0, %[[LIST]] : !torch.vtensor<[1,4],f32>, !torch.list<int> -> !torch.vtensor<[3,4],f32>
  %0 = torch.operator "onnx.Expand"(%arg0, %arg1) : (!torch.vtensor<[1,4],f32>, !torch.vtensor<[2],si32>) -> !torch.vtensor<[3,4],f32>
  return %0 : !torch.vtensor<[3,4],f32>
}

