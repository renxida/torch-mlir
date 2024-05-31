

// CHECK-LABEL: func.func @test_softplus
func.func @test_softplus(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[EXP:.*]] = torch.aten.exp %arg0 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
  // CHECK: torch.aten.log1p %[[EXP]] : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
  %0 = torch.operator "onnx.Softplus"(%arg0) : (!torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32>
  return %0 : !torch.vtensor<[3],f32>
}

