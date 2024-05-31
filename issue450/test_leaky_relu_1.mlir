

// CHECK-LABEL: func.func @test_leaky_relu
func.func @test_leaky_relu(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.opset_version = 16 : si64} {
  // CHECK-DAG: %[[F2:.+]] = torch.constant.float 2
  // CHECK: %[[LRELU:.+]] = torch.aten.leaky_relu %arg0, %[[F2]]
  %0 = torch.operator "onnx.LeakyRelu"(%arg0) {torch.onnx.alpha = 2.000000e+00 : f32} : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

