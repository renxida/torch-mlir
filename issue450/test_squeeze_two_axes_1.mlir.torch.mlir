module {
  func.func @test_squeeze_two_axes(%arg0: !torch.vtensor<[3,1,4,5,1],f32>, %arg1: !torch.vtensor<[2],si64>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int4 = torch.constant.int 4
    %0 = torch.prim.ListConstruct %int1, %int4 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prims.squeeze %arg0, %0 : !torch.vtensor<[3,1,4,5,1],f32>, !torch.list<int> -> !torch.vtensor<[3,4,5],f32>
    return %1 : !torch.vtensor<[3,4,5],f32>
  }
}

