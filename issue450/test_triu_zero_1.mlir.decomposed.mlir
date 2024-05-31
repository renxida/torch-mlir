module {
  func.func @test_triu_zero(%arg0: !torch.vtensor<[0,5],si64>, %arg1: !torch.vtensor<[],si64>) -> !torch.vtensor<[0,5],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %int4 = torch.constant.int 4
    %int5 = torch.constant.int 5
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %1 = torch.aten.item %arg1 : !torch.vtensor<[],si64> -> !torch.int
    %2 = torch.aten.arange.start_step %int0, %int0, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[0],si64>
    %3 = torch.aten.arange.start_step %int0, %int5, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[5],si64>
    %4 = torch.aten.unsqueeze %2, %int1 : !torch.vtensor<[0],si64>, !torch.int -> !torch.vtensor<[0,1],si64>
    %5 = torch.aten.unsqueeze %3, %int0 : !torch.vtensor<[5],si64>, !torch.int -> !torch.vtensor<[1,5],si64>
    %6 = torch.aten.add.Scalar %4, %1, %int1 : !torch.vtensor<[0,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[0,1],si64>
    %7 = torch.aten.ge.Tensor %5, %6 : !torch.vtensor<[1,5],si64>, !torch.vtensor<[0,1],si64> -> !torch.vtensor<[0,5],i1>
    %8 = torch.aten.where.self %7, %arg0, %0 : !torch.vtensor<[0,5],i1>, !torch.vtensor<[0,5],si64>, !torch.vtensor<[],si64> -> !torch.vtensor<[0,5],si64>
    return %8 : !torch.vtensor<[0,5],si64>
  }
}

