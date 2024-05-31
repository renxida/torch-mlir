module {
  func.func @test_eyelike_m(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %0 = torch.aten.eye.m %int3, %int4, %int6, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,4],f32>
    return %0 : !torch.vtensor<[3,4],f32>
  }
}

