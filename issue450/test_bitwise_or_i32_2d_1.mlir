

// CHECK-LABEL: @test_bitwise_or_i32_2d
func.func @test_bitwise_or_i32_2d(%arg0: !torch.vtensor<[3,4],si32>, %arg1: !torch.vtensor<[3,4],si32>) -> !torch.vtensor<[3,4],si32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.bitwise_or.Tensor %arg0, %arg1 : !torch.vtensor<[3,4],si32>, !torch.vtensor<[3,4],si32> -> !torch.vtensor<[3,4],si32>
  %0 = torch.operator "onnx.BitwiseOr"(%arg0, %arg1) : (!torch.vtensor<[3,4],si32>, !torch.vtensor<[3,4],si32>) -> !torch.vtensor<[3,4],si32>
  return %0 : !torch.vtensor<[3,4],si32>
}

