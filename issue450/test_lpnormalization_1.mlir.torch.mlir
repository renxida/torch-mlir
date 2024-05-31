module {
  func.func @test_lpnormalization(%arg0: !torch.vtensor<[3,4,5,6,7],f32>) -> !torch.vtensor<[3,4,1,6,7],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 22 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %true = torch.constant.bool true
    %0 = torch.prim.ListConstruct %int2 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.norm.ScalarOpt_dim %arg0, %int2, %0, %true : !torch.vtensor<[3,4,5,6,7],f32>, !torch.int, !torch.list<int>, !torch.bool -> !torch.vtensor<[3,4,1,6,7],f32>
    return %1 : !torch.vtensor<[3,4,1,6,7],f32>
  }
}

