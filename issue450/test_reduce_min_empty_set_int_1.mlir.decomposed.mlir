module {
  func.func @test_reduce_min_empty_set_int(%arg0: !torch.vtensor<[2,0,4],si32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,1,4],si32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<2147483647> : tensor<2x1x4xsi32>) : !torch.vtensor<[2,1,4],si32>
    return %0 : !torch.vtensor<[2,1,4],si32>
  }
}

