module {
  func.func @dense_constant_i1() -> !torch.vtensor<[5],i1> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 17 : si64} {
    %0 = torch.vtensor.literal(dense<[true, false, false, true, true]> : tensor<5xi1>) : !torch.vtensor<[5],i1>
    return %0 : !torch.vtensor<[5],i1>
  }
}

