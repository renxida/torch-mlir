module {
  func.func @test_reshape_one_dim(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[24],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int24 = torch.constant.int 24
    %0 = torch.prim.ListConstruct %int24 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.view %arg0, %0 : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[24],f32>
    return %1 : !torch.vtensor<[24],f32>
  }
}

