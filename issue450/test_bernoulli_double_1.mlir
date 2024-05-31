

// CHECK-LABEL: @test_bernoulli_double
func.func @test_bernoulli_double(%arg0: !torch.vtensor<[10],f32>) -> !torch.vtensor<[10],f64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[BERNOULLI:.*]] = torch.aten.bernoulli %arg0, %[[NONE]] : !torch.vtensor<[10],f32>, !torch.none -> !torch.vtensor<[10],f32>
  // CHECK: %[[DTYPE:.*]] = torch.constant.int 7
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: torch.aten.to.dtype %[[BERNOULLI]], %[[DTYPE]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[10],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[10],f64>
  %0 = torch.operator "onnx.Bernoulli"(%arg0) {torch.onnx.dtype = 11 : si64} : (!torch.vtensor<[10],f32>) -> !torch.vtensor<[10],f64>
  return %0 : !torch.vtensor<[10],f64>
}

