module {
  func.func @test_cast_FLOAT_to_BFLOAT16(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],bf16> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int15 = torch.constant.int 15
    %none = torch.constant.none
    %false = torch.constant.bool false
    %0 = torch.aten.to.dtype %arg0, %int15, %false, %false, %none : !torch.vtensor<[3,4],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,4],bf16>
    return %0 : !torch.vtensor<[3,4],bf16>
  }
}

