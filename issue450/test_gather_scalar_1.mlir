

// CHECK-LABEL: func.func @test_gather_scalar
func.func @test_gather_scalar(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[], si64>) -> !torch.vtensor<[4,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK: %[[AXIS:.+]] = torch.constant.int 0
  // CHECK: %[[ZERO:.+]] = torch.constant.int 0
  // CHECK: %[[ONE:.+]] = torch.constant.int 1
  // CHECK: %[[LT:.+]] = torch.aten.lt.Scalar %arg1, %[[ZERO]]
  // CHECK: %[[SZ:.+]] = torch.aten.size.int %arg0, %[[AXIS]]
  // CHECK: %[[ADD:.+]] = torch.aten.add.Scalar %arg1, %[[SZ]], %[[ONE]]
  // CHECK: %[[SEL:.+]] = torch.aten.where.self %[[LT]], %[[ADD]], %arg1
  // CHECK: %[[FLAT:.+]] = torch.aten.unsqueeze %[[SEL]], %[[ZERO]] : !torch.vtensor<[],si64>, !torch.int -> !torch.vtensor<[1],si64>
  // CHECK: %[[ISEL:.+]] = torch.aten.index_select %arg0, %[[AXIS]], %[[FLAT]]
  // CHECK: %[[RES:.+]] = torch.aten.squeeze %[[ISEL]] : !torch.vtensor<[1,4,5],f32> -> !torch.vtensor<[4,5],f32>
  // CHECK: return %[[RES]]
  %0 = torch.operator "onnx.Gather"(%arg0, %arg1) {torch.onnx.axis = 0 : si64} : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[], si64>) -> !torch.vtensor<[4,5],f32>
  return %0 : !torch.vtensor<[4,5],f32>
}

