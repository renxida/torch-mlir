module {
  func.func @test_reshape_negative_dim(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,6,2],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int6 = torch.constant.int 6
    %0 = torch.prim.ListConstruct %int2, %int6, %int2 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.view %arg0, %0 : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,6,2],f32>
    return %1 : !torch.vtensor<[2,6,2],f32>
  }
}

