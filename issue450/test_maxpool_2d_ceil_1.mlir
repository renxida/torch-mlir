

// CHECK-LABEL: func.func @test_maxpool_2d_ceil
func.func @test_maxpool_2d_ceil(%arg0: !torch.vtensor<[1,1,4,4],f32>) -> !torch.vtensor<[1,1,2,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64} {
  // CHECK: %[[I3:.*]] = torch.constant.int 3
  // CHECK: %[[I3_1:.*]] = torch.constant.int 3
  // CHECK: %[[LIST33:.*]] = torch.prim.ListConstruct %[[I3]], %[[I3_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[I0_0:.*]] = torch.constant.int 0
  // CHECK: %[[I0_1:.*]] = torch.constant.int 0
  // CHECK: %[[LIST0:.*]] = torch.prim.ListConstruct %[[I0_0]], %[[I0_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[I2:.*]] = torch.constant.int 2
  // CHECK: %[[I2_1:.*]] = torch.constant.int 2
  // CHECK: %[[LIST22:.*]] = torch.prim.ListConstruct %[[I2]], %[[I2_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[I1_0:.*]] = torch.constant.int 1
  // CHECK: %[[I1_1:.*]] = torch.constant.int 1
  // CHECK: %[[LIST:.*]] = torch.prim.ListConstruct %[[I1_0]], %[[I1_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[TRUE:.*]] = torch.constant.bool true
  // CHECK: torch.aten.max_pool2d %arg0, %[[LIST33]], %[[LIST22]], %[[LIST0]], %[[LIST]], %[[TRUE]] : !torch.vtensor<[1,1,4,4],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,1,2,2],f32>
  %0 = torch.operator "onnx.MaxPool"(%arg0) {torch.onnx.ceil_mode = 1 : si64, torch.onnx.kernel_shape = [3 : si64, 3 : si64], torch.onnx.strides = [2 : si64, 2 : si64]} : (!torch.vtensor<[1,1,4,4],f32>) -> !torch.vtensor<[1,1,2,2],f32>
  return %0 : !torch.vtensor<[1,1,2,2],f32>
}

