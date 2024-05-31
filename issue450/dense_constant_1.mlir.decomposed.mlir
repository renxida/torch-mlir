module {
  func.func @dense_constant() -> !torch.vtensor<[1],si64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %0 = torch.vtensor.literal(dense<13> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    return %0 : !torch.vtensor<[1],si64>
  }
}

