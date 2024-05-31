

// CHECK-LABEL: @test_dropout_default_ratio
func.func @test_dropout_default_ratio(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.dropout %arg0, %0, %false : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.bool -> !torch.vtensor<[3,4,5],f32>
  %0 = torch.operator "onnx.Dropout"(%arg0, %arg1) {torch.onnx.seed = 0 : si64} : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

