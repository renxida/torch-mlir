

// CHECK-LABEL: func.func @test_nonzero
  func.func @test_nonzero(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.nonzero %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],si64>
    %0 = torch.operator "onnx.NonZero"(%arg0) : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],si64>
    return %0 : !torch.vtensor<[3,4,5],si64>
  }

