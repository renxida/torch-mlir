

// CHECK-LABEL: func.func @test_sigmoid_example
func.func @test_sigmoid_example(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.sigmoid %arg0 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
  %0 = torch.operator "onnx.Sigmoid"(%arg0) : (!torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32>
  return %0 : !torch.vtensor<[3],f32>
}

