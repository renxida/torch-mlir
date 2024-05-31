module {
  func.func @test_cumsum_1d_exclusive(%arg0: !torch.vtensor<[5],f64>, %arg1: !torch.vtensor<[],si32>) -> !torch.vtensor<[5],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg1 : !torch.vtensor<[],si32> -> !torch.int
    %1 = torch.aten.lt.int %0, %int0 : !torch.int, !torch.int -> !torch.bool
    %2 = torch.aten.Int.bool %1 : !torch.bool -> !torch.int
    %3 = torch.aten.mul.int %2, %int1 : !torch.int, !torch.int -> !torch.int
    %4 = torch.aten.add.int %0, %3 : !torch.int, !torch.int -> !torch.int
    %5 = torch.aten.cumsum %arg0, %4, %none : !torch.vtensor<[5],f64>, !torch.int, !torch.none -> !torch.vtensor<[5],f64>
    %6 = torch.aten.sub.Tensor %5, %arg0, %int1 : !torch.vtensor<[5],f64>, !torch.vtensor<[5],f64>, !torch.int -> !torch.vtensor<[5],f64>
    return %6 : !torch.vtensor<[5],f64>
  }
}

