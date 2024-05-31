

// CHECK-LABEL: func.func @test_hardmax
func.func @test_hardmax(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[ARGMAX:.+]] = torch.aten.argmax %arg0, %int6, %false : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.bool -> !torch.vtensor<[3,4,5],f32>
  // CHECK: torch.aten.one_hot %[[ARGMAX]], %int1 : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,4,5],f32>
  %0 = torch.operator "onnx.Hardmax"(%arg0) {torch.onnx.axis = 1 : si64} : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

