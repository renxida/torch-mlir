module {
  func.func @test_triu(%arg0: !torch.vtensor<[4,5],si64>) -> !torch.vtensor<[4,5],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %none = torch.constant.none
    %int4 = torch.constant.int 4
    %int5 = torch.constant.int 5
    %1 = torch.aten.arange.start_step %int0, %int4, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[4],si64>
    %2 = torch.aten.arange.start_step %int0, %int5, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[5],si64>
    %3 = torch.aten.unsqueeze %1, %int1 : !torch.vtensor<[4],si64>, !torch.int -> !torch.vtensor<[4,1],si64>
    %4 = torch.aten.unsqueeze %2, %int0 : !torch.vtensor<[5],si64>, !torch.int -> !torch.vtensor<[1,5],si64>
    %5 = torch.aten.add.Scalar %3, %int0, %int1 : !torch.vtensor<[4,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[4,1],si64>
    %6 = torch.aten.ge.Tensor %4, %5 : !torch.vtensor<[1,5],si64>, !torch.vtensor<[4,1],si64> -> !torch.vtensor<[4,5],i1>
    %7 = torch.aten.where.self %6, %arg0, %0 : !torch.vtensor<[4,5],i1>, !torch.vtensor<[4,5],si64>, !torch.vtensor<[],si64> -> !torch.vtensor<[4,5],si64>
    return %7 : !torch.vtensor<[4,5],si64>
  }
}

