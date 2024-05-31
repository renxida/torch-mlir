

// CHECK-LABEL: @dense_constant_i1
func.func @dense_constant_i1() -> !torch.vtensor<[5],i1> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 17 : si64} {
  // CHECK: %[[CST:.+]] = torch.vtensor.literal(dense<[true, false, false, true, true]> : tensor<5xi1>) : !torch.vtensor<[5],i1>
  // CHECK: return %[[CST]] : !torch.vtensor<[5],i1>
  %0 = torch.operator "onnx.Constant"() {torch.onnx.value = dense_resource<_> : tensor<5xi1>} : () -> !torch.vtensor<[5],i1>
  return %0 : !torch.vtensor<[5],i1>
}

{-#
  dialect_resources: {
    builtin: {
      _: "0x080000000100000101"
    }
  }
#-}

