

// CHECK-LABEL: @float_constant
func.func @float_constant() -> !torch.vtensor<[], f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
  // CHECK: %[[CST:.+]] = torch.vtensor.literal(dense<2.500000e-01> : tensor<f32>) : !torch.vtensor<[],f32>
  // CHECK: return %[[CST]]
  %0 = torch.operator "onnx.Constant"() {torch.onnx.value_float = 0.25 : f32} : () -> !torch.vtensor<[],f32>
  return %0 : !torch.vtensor<[],f32>
}

