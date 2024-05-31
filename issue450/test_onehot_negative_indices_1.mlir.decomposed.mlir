module {
  func.func @test_onehot_negative_indices(%arg0: !torch.vtensor<[3],si64>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[2],f32>) -> !torch.vtensor<[3,10],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %int4 = torch.constant.int 4
    %int2 = torch.constant.int 2
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
    %5 = torch.aten.slice.Tensor %arg2, %int0, %int0, %int1, %int1 : !torch.vtensor<[2],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],f32>
    %6 = torch.aten.item %5 : !torch.vtensor<[1],f32> -> !torch.float
    %7 = torch.aten.slice.Tensor %arg2, %int0, %int1, %int2, %int1 : !torch.vtensor<[2],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],f32>
    %8 = torch.aten.item %7 : !torch.vtensor<[1],f32> -> !torch.float
    %9 = torch.aten.arange.start_step %int0, %1, %int1, %none, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[?],si64>
    %10 = torch.aten.unsqueeze %4, %int1 : !torch.vtensor<[3],si64>, !torch.int -> !torch.vtensor<[3,1],si64>
    %11 = torch.aten.eq.Tensor %10, %9 : !torch.vtensor<[3,1],si64>, !torch.vtensor<[?],si64> -> !torch.vtensor<[3,?],i1>
    %12 = torch.aten.to.dtype %11, %int4, %false, %false, %none : !torch.vtensor<[3,?],i1>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,?],si64>
    %13 = torch.aten.to.dtype %12, %int11, %false, %false, %none : !torch.vtensor<[3,?],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,?],i1>
    %14 = torch.prim.NumToTensor.Scalar %8 : !torch.float -> !torch.vtensor<[],f64>
    %15 = torch.aten.to.dtype %14, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %16 = torch.prim.NumToTensor.Scalar %6 : !torch.float -> !torch.vtensor<[],f64>
    %17 = torch.aten.to.dtype %16, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %18 = torch.aten.where.self %13, %15, %17 : !torch.vtensor<[3,?],i1>, !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[3,10],f32>
    return %18 : !torch.vtensor<[3,10],f32>
  }
}

