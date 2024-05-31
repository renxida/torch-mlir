

// CHECK-LABEL: @dense_constant
func.func @dense_constant() -> () attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
  // CHECK: torch.vtensor.literal(dense<[0, 10, 128, 17000]> : tensor<4xsi32>) : !torch.vtensor<[4],si32>
  %0 = torch.operator "onnx.Constant"() {torch.onnx.value = dense_resource<_int32> : tensor<4xsi32>} : () -> !torch.vtensor<[4],si32>
  // CHECK: torch.vtensor.literal(dense<[0.000000e+00, 1.000000e+01, 1.280000e+02, 1.700000e+04]> : tensor<4xf32>) : !torch.vtensor<[4],f32>
  %1 = torch.operator "onnx.Constant"() {torch.onnx.value = dense_resource<_float32> : tensor<4xf32>} : () -> !torch.vtensor<[4],f32>
  // CHECK: torch.vtensor.literal(dense<[-128, -1, 50, 127]> : tensor<4xsi8>) : !torch.vtensor<[4],si8>
  %2 = torch.operator "onnx.Constant"() {torch.onnx.value = dense_resource<_int8> : tensor<4xsi8>} : () -> !torch.vtensor<[4],si8>
  // CHECK: torch.vtensor.literal(dense<[128, 255, 50, 127]> : tensor<4xui8>) : !torch.vtensor<[4],ui8>
  %3 = torch.operator "onnx.Constant"() {torch.onnx.value = dense_resource<_int8> : tensor<4xui8>} : () -> !torch.vtensor<[4],ui8>
  return
}

{-#
  dialect_resources: {
    builtin: {
      _int8: "0x0800000080FF327F",
      _int32: "0x08000000000000000a0000008000000068420000",
      _float32: "0x0800000000000000000020410000004300d08446"
    }
  }
#-}

