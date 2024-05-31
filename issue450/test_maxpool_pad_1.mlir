

// CHECK-LABEL: func.func @test_maxpool_pad
func.func @test_maxpool_pad(%arg0: !torch.vtensor<[1,64,111,111],f32>) -> !torch.vtensor<[1,64,56,56],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64} {
  // CHECK: %[[INT1_0:.+]] = torch.constant.int 1
  // CHECK: %[[INT1_1:.+]] = torch.constant.int 1
  // CHECK: %[[INT2_0:.+]] = torch.constant.int 2
  // CHECK: %[[INT2_1:.+]] = torch.constant.int 2
  // CHECK: %[[PADI:.+]] = torch.prim.ListConstruct %[[INT1_0]], %[[INT1_1]], %[[INT2_0]], %[[INT2_1]] : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[MIN:.+]] = torch.constant.float -1.7976931348623157E+308
  // CHECK: %[[PADDED:.+]] = torch.aten.constant_pad_nd %arg0, %[[PADI]], %[[MIN]] : !torch.vtensor<[1,64,111,111],f32>, !torch.list<int>, !torch.float -> !torch.vtensor<[1,64,114,114],f32>
  // CHECK: %[[INT3:.*]] = torch.constant.int 3
  // CHECK: %[[INT3_0:.*]] = torch.constant.int 3
  // CHECK: %[[LIST:.*]] = torch.prim.ListConstruct %[[INT3]], %[[INT3_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT0_1:.*]] = torch.constant.int 0
  // CHECK: %[[LIST2:.*]] = torch.prim.ListConstruct %[[INT0]], %[[INT0_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[INT2:.*]] = torch.constant.int 2
  // CHECK: %[[INT2_4:.*]] = torch.constant.int 2
  // CHECK: %[[LIST3:.*]] = torch.prim.ListConstruct %[[INT2]], %[[INT2_4]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[INT1_0:.*]] = torch.constant.int 1
  // CHECK: %[[INT1_1:.*]] = torch.constant.int 1
  // CHECK: %[[EMPTY_LIST:.*]] = torch.prim.ListConstruct %[[INT1_0]], %[[INT1_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[OUT:.*]] = torch.aten.max_pool2d %[[PADDED]], %[[LIST]], %[[LIST3]], %[[LIST2]], %[[EMPTY_LIST]], %[[FALSE]] : !torch.vtensor<[1,64,114,114],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,64,56,56],f32>
  // CHECK: return %[[OUT]] : !torch.vtensor<[1,64,56,56],f32>
  %0 = torch.operator "onnx.MaxPool"(%arg0) {torch.onnx.ceil_mode = 0 : si64, torch.onnx.kernel_shape = [3 : si64, 3 : si64], torch.onnx.pads = [1 : si64, 1 : si64, 2 : si64, 2 : si64], torch.onnx.strides = [2 : si64, 2 : si64]} : (!torch.vtensor<[1,64,111,111],f32>) -> !torch.vtensor<[1,64,56,56],f32>
  return %0 : !torch.vtensor<[1,64,56,56],f32>
}


