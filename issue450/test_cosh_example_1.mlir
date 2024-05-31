

// CHECK-LABEL: @test_cosh_example
func.func @test_cosh_example(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.cosh %arg0 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
  %0 = torch.operator "onnx.Cosh"(%arg0) : (!torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32>
  return %0 : !torch.vtensor<[3],f32>
}

