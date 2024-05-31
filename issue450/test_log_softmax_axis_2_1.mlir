

// CHECK-LABEL: func.func @test_log_softmax_axis_2
  func.func @test_log_softmax_axis_2(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[CI2:.*]] = torch.constant.int 2
    // CHECK: %[[NONE:.*]] = torch.constant.none
    // CHECK: %[[LSM:.*]] = torch.aten.log_softmax.int %arg0, %[[CI2]], %[[NONE]] : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.none -> !torch.vtensor<[3,4,5],f32>
    // CHECK: return %[[LSM]] : !torch.vtensor<[3,4,5],f32>
    %0 = torch.operator "onnx.LogSoftmax"(%arg0) {torch.onnx.axis = 2 : si64} : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }

