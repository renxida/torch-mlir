module {
  func.func @test_bernoulli_double(%arg0: !torch.vtensor<[10],f32>) -> !torch.vtensor<[10],f64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int7 = torch.constant.int 7
    %none = torch.constant.none
    %0 = torch.aten.bernoulli %arg0, %none : !torch.vtensor<[10],f32>, !torch.none -> !torch.vtensor<[10],f32>
    %1 = torch.aten.to.dtype %0, %int7, %false, %false, %none : !torch.vtensor<[10],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[10],f64>
    return %1 : !torch.vtensor<[10],f64>
  }
}

