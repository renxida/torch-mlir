

// CHECK-LABEL: @test_expand_dim2_shape3
func.func @test_expand_dim2_shape3(%arg0: !torch.vtensor<[3,1],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,3,6],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK:  %[[I0:.+]] = torch.constant.int 0
  // CHECK-NEXT:  %[[I0_0:.+]] = torch.constant.int 0
  // CHECK-NEXT:  %[[SEL0:.+]] = torch.aten.select.int %arg1, %[[I0]], %[[I0_0]]
  // CHECK-NEXT:  %[[ITEM0:.+]] = torch.aten.item %[[SEL0]]
  // CHECK-NEXT:  %[[I1:.+]] = torch.constant.int 1
  // CHECK-NEXT:  %[[SEL1:.+]] = torch.aten.select.int %arg1, %[[I0]], %[[I1]]
  // CHECK-NEXT:  %[[ITEM1:.+]] = torch.aten.item %[[SEL1]]
  // CHECK-NEXT:  %[[D1:.+]] = torch.constant.int 0
  // CHECK-NEXT:  %[[SZ1:.+]] = torch.aten.size.int %arg0, %[[D1]]
  // CHECK-NEXT:  %[[MX1:.+]] = torch.prim.max.int %[[ITEM1]], %[[SZ1]] : !torch.int, !torch.int -> !torch.int
  // CHECK-NEXT:  %[[I2:.+]] = torch.constant.int 2
  // CHECK-NEXT:  %[[SEL2:.+]] = torch.aten.select.int %arg1, %[[I0]], %[[I2]]
  // CHECK-NEXT:  %[[ITEM2:.+]] = torch.aten.item %[[SEL2]]
  // CHECK-NEXT:  %[[D2:.+]] = torch.constant.int 1
  // CHECK-NEXT:  %[[SZ2:.+]] = torch.aten.size.int %arg0, %[[D2]]
  // CHECK-NEXT:  %[[MX2:.+]] = torch.prim.max.int %[[ITEM2]], %[[SZ2]]
  // CHECK-NEXT:  %[[LIST:.+]] = torch.prim.ListConstruct %[[ITEM0]], %[[MX1]], %[[MX2]]
  // CHECK-NEXT:  %[[EXPAND:.+]] = torch.aten.broadcast_to %arg0, %[[LIST]]
  // CHECK:  return %[[EXPAND]]
  %0 = torch.operator "onnx.Expand"(%arg0, %arg1) : (!torch.vtensor<[3,1],f32>, !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,3,6],f32>
  return %0 : !torch.vtensor<[2,3,6],f32>
}

