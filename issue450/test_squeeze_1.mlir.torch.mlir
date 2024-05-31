module {
  func.func @test_squeeze(%arg0: !torch.vtensor<[1,3,4,5],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %0 = torch.prim.ListConstruct %int0 : (!torch.int) -> !torch.list<int>
    %1 = torch.prims.squeeze %arg0, %0 : !torch.vtensor<[1,3,4,5],f32>, !torch.list<int> -> !torch.vtensor<[3,4,5],f32>
    return %1 : !torch.vtensor<[3,4,5],f32>
  }
}

