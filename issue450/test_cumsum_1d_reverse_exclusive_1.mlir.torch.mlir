module {
  func.func @test_cumsum_1d_reverse_exclusive(%arg0: !torch.vtensor<[5],f64>, %arg1: !torch.vtensor<[],si32>) -> !torch.vtensor<[5],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg1 : !torch.vtensor<[],si32> -> !torch.int
    %1 = torch.aten.lt.int %0, %int0 : !torch.int, !torch.int -> !torch.bool
    %2 = torch.aten.Int.bool %1 : !torch.bool -> !torch.int
    %3 = torch.aten.mul.int %2, %int1 : !torch.int, !torch.int -> !torch.int
    %4 = torch.aten.add.int %0, %3 : !torch.int, !torch.int -> !torch.int
    %5 = torch.prim.ListConstruct %4 : (!torch.int) -> !torch.list<int>
    %6 = torch.aten.flip %arg0, %5 : !torch.vtensor<[5],f64>, !torch.list<int> -> !torch.vtensor<[5],f64>
    %7 = torch.aten.cumsum %6, %4, %none : !torch.vtensor<[5],f64>, !torch.int, !torch.none -> !torch.vtensor<[5],f64>
    %8 = torch.aten.flip %7, %5 : !torch.vtensor<[5],f64>, !torch.list<int> -> !torch.vtensor<[5],f64>
    %9 = torch.aten.sub.Tensor %8, %arg0, %int1 : !torch.vtensor<[5],f64>, !torch.vtensor<[5],f64>, !torch.int -> !torch.vtensor<[5],f64>
    return %9 : !torch.vtensor<[5],f64>
  }
}

