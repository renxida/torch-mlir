

// CHECK-LABEL: @test_conv_with_bias_strides_padding
func.func @test_conv_with_bias_strides_padding(%arg0: !torch.vtensor<[?,?,224,224],f32>, %arg1: !torch.vtensor<[64,3,7,7],f32>, %arg2: !torch.vtensor<[64],f32>) -> !torch.vtensor<[?,64,112,112],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C3:.*]] = torch.constant.int 3
  // CHECK: %[[C3_0:.*]] = torch.constant.int 3
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[C1_0:.*]] = torch.constant.int 1
  // CHECK: %[[C2:.*]] = torch.constant.int 2
  // CHECK: %[[C2_0:.*]] = torch.constant.int 2
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[PADDING:.*]] = torch.prim.ListConstruct %[[C3]], %[[C3_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[DILATIONS:.*]] = torch.prim.ListConstruct %[[C1]], %[[C1_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[STRIDE:.*]] = torch.prim.ListConstruct %[[C2]], %[[C2_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[OUTPUT_PADDING:.*]] = torch.prim.ListConstruct %[[C0]], %[[C0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[TRANSPOSED:.*]] = torch.constant.bool false
  // CHECK: %[[GROUPS:.*]] = torch.constant.int 1
  // CHECK: torch.aten.convolution %arg0, %arg1, %arg2, %[[STRIDE]], %[[PADDING]], %[[DILATIONS]], %[[TRANSPOSED]], %[[OUTPUT_PADDING]], %[[GROUPS]] : !torch.vtensor<[?,?,224,224],f32>, !torch.vtensor<[64,3,7,7],f32>, !torch.vtensor<[64],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[?,64,112,112],f32>
  %0 = torch.operator "onnx.Conv"(%arg0, %arg1, %arg2) {torch.onnx.dilations = [1 : si64, 1 : si64], torch.onnx.group = 1 : si64, torch.onnx.kernel_shape = [7 : si64, 7 : si64], torch.onnx.pads = [3 : si64, 3 : si64, 3 : si64, 3 : si64], torch.onnx.strides = [2 : si64, 2 : si64]} : (!torch.vtensor<[?,?,224,224],f32>, !torch.vtensor<[64,3,7,7],f32>, !torch.vtensor<[64],f32>) -> !torch.vtensor<[?,64,112,112],f32>
  return %0 : !torch.vtensor<[?,64,112,112],f32>
}

