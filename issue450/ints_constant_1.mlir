

// CHECK-LABEL: @ints_constant
func.func @ints_constant() -> !torch.vtensor<[2], si64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
  // CHECK: %[[CST:.+]] = torch.vtensor.literal(dense<[7, 9]> : tensor<2xsi64>) : !torch.vtensor<[2],si64>
  // CHECK: return %[[CST]]
  %0 = "torch.operator"() <{name = "onnx.Constant"}> {torch.onnx.value_ints = [7 : si64, 9 : si64]} : () -> !torch.vtensor<[2],si64>
  return %0 : !torch.vtensor<[2],si64>
}

