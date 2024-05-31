

// CHECK-LABEL:   func.func @test_exp
func.func @test_exp(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64} {
  // CHECK:  torch.aten.exp %arg0 : !torch.vtensor<[3,4],f32> -> !torch.vtensor<[3,4],f32>
  %0 = torch.operator "onnx.Exp"(%arg0) : (!torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32>
  return %0 : !torch.vtensor<[3,4],f32>
}

