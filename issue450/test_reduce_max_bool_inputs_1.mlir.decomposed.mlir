module {
  func.func @test_reduce_max_bool_inputs(%arg0: !torch.vtensor<[4,2],i1>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[4,1],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg1 : !torch.vtensor<[1],si64> -> !torch.int
    %1 = torch.aten.lt.int %0, %int0 : !torch.int, !torch.int -> !torch.bool
    %2 = torch.aten.Int.bool %1 : !torch.bool -> !torch.int
    %3 = torch.aten.mul.int %2, %int2 : !torch.int, !torch.int -> !torch.int
    %4 = torch.aten.add.int %0, %3 : !torch.int, !torch.int -> !torch.int
    %5 = torch.prim.ListConstruct %4 : (!torch.int) -> !torch.list<int>
    %6 = torch.aten.amax %arg0, %5, %true : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[4,1],i1>
    return %6 : !torch.vtensor<[4,1],i1>
  }
}

