module {
  func.func @test_gather_nd_1D_indices(%arg0: !torch.vtensor<[2,6,8,5],f32>, %arg1: !torch.vtensor<[2],si64>) -> !torch.vtensor<[8,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
    %false = torch.constant.bool false
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %int6 = torch.constant.int 6
    %int8 = torch.constant.int 8
    %int5 = torch.constant.int 5
    %0 = torch.aten.slice.Tensor %arg1, %int0, %int0, %int1, %int1 : !torch.vtensor<[2],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.lt.Scalar %0, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[1],i1>
    %2 = torch.aten.add.Scalar %0, %int2, %int1 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %3 = torch.aten.where.self %1, %2, %0 : !torch.vtensor<[1],i1>, !torch.vtensor<[1],si64>, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %4 = torch.aten.slice.Tensor %arg1, %int0, %int1, %int2, %int1 : !torch.vtensor<[2],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %5 = torch.aten.lt.Scalar %4, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[1],i1>
    %6 = torch.aten.add.Scalar %4, %int6, %int1 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %7 = torch.aten.where.self %5, %6, %4 : !torch.vtensor<[1],i1>, !torch.vtensor<[1],si64>, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %8 = torch.aten.add.Tensor %7, %3, %int6 : !torch.vtensor<[1],si64>, !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[1],si64>
    %9 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.aten.view %8, %9 : !torch.vtensor<[1],si64>, !torch.list<int> -> !torch.vtensor<[1,1],si64>
    %11 = torch.aten.unsqueeze %10, %int0 : !torch.vtensor<[1,1],si64>, !torch.int -> !torch.vtensor<[1,1,1],si64>
    %12 = torch.prim.ListConstruct %int1, %int8, %int5 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %13 = torch.aten.expand %11, %12, %false : !torch.vtensor<[1,1,1],si64>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,8,5],si64>
    %14 = torch.aten.flatten.using_ints %arg0, %int0, %int1 : !torch.vtensor<[2,6,8,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[12,8,5],f32>
    %15 = torch.aten.gather %14, %int0, %13, %false : !torch.vtensor<[12,8,5],f32>, !torch.int, !torch.vtensor<[1,8,5],si64>, !torch.bool -> !torch.vtensor<[1,8,5],f32>
    %16 = torch.aten.squeeze.dim %15, %int0 : !torch.vtensor<[1,8,5],f32>, !torch.int -> !torch.vtensor<[8,5],f32>
    return %16 : !torch.vtensor<[8,5],f32>
  }
}

