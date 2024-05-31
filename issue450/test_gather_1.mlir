

// CHECK-LABEL: func.func @test_gather
func.func @test_gather(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[8,10,20,40], si64>) -> !torch.vtensor<[8,10,20,40,4,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK: %[[AXIS:.+]] = torch.constant.int 0
  // CHECK: %[[ZERO:.+]] = torch.constant.int 0
  // CHECK: %[[ONE:.+]] = torch.constant.int 1
  // CHECK: %[[LT:.+]] = torch.aten.lt.Scalar %arg1, %[[ZERO]]
  // CHECK: %[[SZ:.+]] = torch.aten.size.int %arg0, %[[AXIS]]
  // CHECK: %[[ADD:.+]] = torch.aten.add.Scalar %arg1, %[[SZ]], %[[ONE]]
  // CHECK: %[[SEL:.+]] = torch.aten.where.self %[[LT]], %[[ADD]], %arg1
  // CHECK: %[[D0:.+]] = torch.constant.int 0
  // CHECK: %[[SZ0:.+]] = torch.aten.size.int %[[SEL]], %[[D0]]
  // CHECK: %[[D1:.+]] = torch.constant.int 1
  // CHECK: %[[SZ1:.+]] = torch.aten.size.int %[[SEL]], %[[D1]]
  // CHECK: %[[D2:.+]] = torch.constant.int 2
  // CHECK: %[[SZ2:.+]] = torch.aten.size.int %[[SEL]], %[[D2]]
  // CHECK: %[[D3:.+]] = torch.constant.int 3
  // CHECK: %[[SZ3:.+]] = torch.aten.size.int %[[SEL]], %[[D3]]
  // CHECK: %[[SZ:.+]] = torch.prim.ListConstruct %[[SZ0]], %[[SZ1]], %[[SZ2]], %[[SZ3]]
  // CHECK: %[[DIM:.+]] = torch.aten.dim %[[SEL]]
  // CHECK: %[[SUB:.+]] = torch.aten.sub.int %[[DIM]], %[[ONE]]
  // CHECK: %[[FLAT:.+]] = torch.aten.flatten.using_ints %[[SEL]], %[[ZERO]], %[[SUB]]
  // CHECK: %[[ISEL:.+]] = torch.aten.index_select %arg0, %[[AXIS]], %[[FLAT]]
  // CHECK: %[[RES:.+]] = torch.aten.unflatten.int %[[ISEL]], %[[AXIS]], %[[SZ]]
  // CHECK: return %[[RES]]
  %0 = torch.operator "onnx.Gather"(%arg0, %arg1) {torch.onnx.axis = 0 : si64} : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[8,10,20,40], si64>) -> !torch.vtensor<[8,10,20,40,4,5],f32>
  return %0 : !torch.vtensor<[8,10,20,40,4,5],f32>
}

