module {
  func.func @test_reduce_min_bool_inputs_nokeepdims(%arg0: !torch.vtensor<[4,2],i1>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[4],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %false = torch.constant.bool false
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.aten.lt.int %1, %int0 : !torch.int, !torch.int -> !torch.bool
    %3 = torch.aten.Int.bool %2 : !torch.bool -> !torch.int
    %4 = torch.aten.mul.int %3, %int2 : !torch.int, !torch.int -> !torch.int
    %5 = torch.aten.add.int %1, %4 : !torch.int, !torch.int -> !torch.int
    %6 = torch.prim.ListConstruct %5 : (!torch.int) -> !torch.list<int>
    %7 = torch.aten.amin %arg0, %6, %false : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[4],i1>
    return %7 : !torch.vtensor<[4],i1>
  }
}

