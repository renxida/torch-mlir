

// CHECK-LABEL: func.func @test_random_uniform_like
func.func @test_random_uniform_like(%arg0: !torch.vtensor<[10],f32>) -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG:  %[[I6:.+]] = torch.constant.int 6
  // CHECK-DAG:  %[[NONE:.+]] = torch.constant.none
  // CHECK-DAG:  %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[CAST:.+]] = torch.aten.to.dtype %arg0, %[[I6]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[10],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[10],f32>
  // CHECK-DAG:  %[[F0:.+]] = torch.constant.float 0.000000e+00
  // CHECK-DAG:  %[[F1:.+]] = torch.constant.float 1.000000e+00
  // CHECK: torch.aten.uniform %[[CAST]], %[[F0]], %[[F1]], %[[NONE]] : !torch.vtensor<[10],f32>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f32>
  %0 = torch.operator "onnx.RandomUniformLike"(%arg0) {torch.onnx.dtype = 1 : si64, torch.onnx.high = 1.000000e+00 : f32, torch.onnx.low = 0.000000e+00 : f32} : (!torch.vtensor<[10],f32>) -> !torch.vtensor<[10],f32>
  return %0 : !torch.vtensor<[10],f32>
}

