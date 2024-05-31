

// CHECK-LABEL: func.func @test_maxpool_2d_default
func.func @test_maxpool_2d_default(%arg0: !torch.vtensor<[1,3,32,32],f32>) -> !torch.vtensor<[1,3,31,31],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64} {
  // CHECK: %[[I2:.*]] = torch.constant.int 2
  // CHECK: %[[I2_1:.*]] = torch.constant.int 2
  // CHECK: %[[LIST22:.*]] = torch.prim.ListConstruct %[[I2]], %[[I2_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[I0_0:.*]] = torch.constant.int 0
  // CHECK: %[[I0_1:.*]] = torch.constant.int 0
  // CHECK: %[[LIST0:.*]] = torch.prim.ListConstruct %[[I0_0]], %[[I0_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[I1_0:.*]] = torch.constant.int 1
  // CHECK: %[[I1_1:.*]] = torch.constant.int 1
  // CHECK: %[[LIST1:.*]] = torch.prim.ListConstruct %[[I1_0]], %[[I1_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[I1_2:.*]] = torch.constant.int 1
  // CHECK: %[[I1_3:.*]] = torch.constant.int 1
  // CHECK: %[[LIST3:.*]] = torch.prim.ListConstruct %[[I1_2]], %[[I1_3]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: torch.aten.max_pool2d %arg0, %[[LIST22]], %[[LIST1]], %[[LIST0]], %[[LIST3]], %[[FALSE]] : !torch.vtensor<[1,3,32,32],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,3,31,31],f32>
  %0 = torch.operator "onnx.MaxPool"(%arg0) {torch.onnx.kernel_shape = [2 : si64, 2 : si64]} : (!torch.vtensor<[1,3,32,32],f32>) -> !torch.vtensor<[1,3,31,31],f32>
  return %0 : !torch.vtensor<[1,3,31,31],f32>
}

