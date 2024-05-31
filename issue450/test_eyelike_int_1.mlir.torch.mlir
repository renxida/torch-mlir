module {
  func.func @test_eyelike_int(%arg0: !torch.vtensor<[3,3],f32>) -> !torch.vtensor<[3,3],si64> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int4 = torch.constant.int 4
    %none = torch.constant.none
    %int3 = torch.constant.int 3
    %0 = torch.aten.eye.m %int3, %int3, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,3],si64>
    return %0 : !torch.vtensor<[3,3],si64>
  }
}

