module {
  func.func @test_constant_of_shape_dense_int_cst() -> !torch.vtensor<[2,3,4],si64> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<3> : tensor<2x3x4xsi64>) : !torch.vtensor<[2,3,4],si64>
    return %0 : !torch.vtensor<[2,3,4],si64>
  }
}

