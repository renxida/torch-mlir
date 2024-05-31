module {
  func.func @test_reduce_min_all_dims_default(%arg0: !torch.vtensor<[4,2],i1>) -> !torch.vtensor<[],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int0, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.amin %arg0, %0, %false : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[],i1>
    return %1 : !torch.vtensor<[],i1>
  }
}

