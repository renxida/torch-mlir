module {
  func.func @test_onehot_negative_indices(%arg0: !torch.vtensor<[3],si64>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[2],f32>) -> !torch.vtensor<[3,10],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int11 = torch.constant.int 11
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %none = torch.constant.none
    %0 = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.Int.Scalar %0 : !torch.float -> !torch.int
    %2 = torch.aten.lt.Scalar %arg0, %int0 : !torch.vtensor<[3],si64>, !torch.int -> !torch.vtensor<[3],i1>
    %3 = torch.aten.add.Scalar %arg0, %1, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[3],si64>
    %4 = torch.aten.where.self %2, %3, %arg0 : !torch.vtensor<[3],i1>, !torch.vtensor<[3],si64>, !torch.vtensor<[3],si64> -> !torch.vtensor<[3],si64>
    %5 = torch.aten.select.int %arg2, %int0, %int0 : !torch.vtensor<[2],f32>, !torch.int, !torch.int -> !torch.vtensor<[1],f32>
    %6 = torch.aten.item %5 : !torch.vtensor<[1],f32> -> !torch.float
    %7 = torch.aten.select.int %arg2, %int0, %int1 : !torch.vtensor<[2],f32>, !torch.int, !torch.int -> !torch.vtensor<[1],f32>
    %8 = torch.aten.item %7 : !torch.vtensor<[1],f32> -> !torch.float
    %9 = torch.aten.one_hot %4, %1 : !torch.vtensor<[3],si64>, !torch.int -> !torch.vtensor<[3,?],si32>
    %10 = torch.aten.to.dtype %9, %int11, %false, %false, %none : !torch.vtensor<[3,?],si32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,?],i1>
    %11 = torch.aten.where.Scalar %10, %8, %6 : !torch.vtensor<[3,?],i1>, !torch.float, !torch.float -> !torch.vtensor<[3,10],f32>
    return %11 : !torch.vtensor<[3,10],f32>
  }
}

