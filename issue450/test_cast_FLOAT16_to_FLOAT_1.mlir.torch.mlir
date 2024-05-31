module {
  func.func @test_cast_FLOAT16_to_FLOAT(%arg0: !torch.vtensor<[3,4],f16>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %false = torch.constant.bool false
    %0 = torch.aten.to.dtype %arg0, %int6, %false, %false, %none : !torch.vtensor<[3,4],f16>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,4],f32>
    return %0 : !torch.vtensor<[3,4],f32>
  }
}

