module {
  func.func @int_constant() -> !torch.vtensor<[],si64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %0 = torch.vtensor.literal(dense<79> : tensor<si64>) : !torch.vtensor<[],si64>
    return %0 : !torch.vtensor<[],si64>
  }
}

