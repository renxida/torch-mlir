module {
  func.func @test_reduce_max_attr(%arg0: !torch.vtensor<[4,2],i1>) -> !torch.vtensor<[4],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.amax %arg0, %0, %false : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[4],i1>
    return %1 : !torch.vtensor<[4],i1>
  }
}

