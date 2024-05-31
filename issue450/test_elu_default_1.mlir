

// CHECK-LABEL: @test_elu_default
func.func @test_elu_default(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.elu %arg0, %float0.000000e00, %float1.000000e00, %float1.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.float, !torch.float -> !torch.vtensor<[3,4,5],f32>
  %0 = torch.operator "onnx.Elu"(%arg0) : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

