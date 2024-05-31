module {
  func.func @test_gather_nd(%arg0: !torch.vtensor<[2,6,8,5],f32>, %arg1: !torch.vtensor<[2,4,3,2],si64>) -> !torch.vtensor<[2,4,3,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
    %false = torch.constant.bool false
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %int6 = torch.constant.int 6
    %int8 = torch.constant.int 8
    %int5 = torch.constant.int 5
    %int4 = torch.constant.int 4
    %int12 = torch.constant.int 12
    %0 = torch.aten.slice.Tensor %arg1, %int3, %int0, %int1, %int1 : !torch.vtensor<[2,4,3,2],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
    %1 = torch.aten.lt.Scalar %0, %int0 : !torch.vtensor<[2,4,3,1],si64>, !torch.int -> !torch.vtensor<[2,4,3,1],i1>
    %2 = torch.aten.add.Scalar %0, %int6, %int1 : !torch.vtensor<[2,4,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
    %3 = torch.aten.where.self %1, %2, %0 : !torch.vtensor<[2,4,3,1],i1>, !torch.vtensor<[2,4,3,1],si64>, !torch.vtensor<[2,4,3,1],si64> -> !torch.vtensor<[2,4,3,1],si64>
    %4 = torch.aten.slice.Tensor %arg1, %int3, %int1, %int2, %int1 : !torch.vtensor<[2,4,3,2],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
    %5 = torch.aten.lt.Scalar %4, %int0 : !torch.vtensor<[2,4,3,1],si64>, !torch.int -> !torch.vtensor<[2,4,3,1],i1>
    %6 = torch.aten.add.Scalar %4, %int8, %int1 : !torch.vtensor<[2,4,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
    %7 = torch.aten.where.self %5, %6, %4 : !torch.vtensor<[2,4,3,1],i1>, !torch.vtensor<[2,4,3,1],si64>, !torch.vtensor<[2,4,3,1],si64> -> !torch.vtensor<[2,4,3,1],si64>
    %8 = torch.aten.add.Tensor %7, %3, %int8 : !torch.vtensor<[2,4,3,1],si64>, !torch.vtensor<[2,4,3,1],si64>, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
    %9 = torch.prim.ListConstruct %int2, %int4, %int3, %int1 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.aten.view %8, %9 : !torch.vtensor<[2,4,3,1],si64>, !torch.list<int> -> !torch.vtensor<[2,4,3,1],si64>
    %11 = torch.aten.flatten.using_ints %10, %int1, %int2 : !torch.vtensor<[2,4,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,12,1],si64>
    %12 = torch.prim.ListConstruct %int2, %int12, %int5 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %13 = torch.aten.expand %11, %12, %false : !torch.vtensor<[2,12,1],si64>, !torch.list<int>, !torch.bool -> !torch.vtensor<[2,12,5],si64>
    %14 = torch.aten.flatten.using_ints %arg0, %int1, %int2 : !torch.vtensor<[2,6,8,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[2,48,5],f32>
    %15 = torch.aten.gather %14, %int1, %13, %false : !torch.vtensor<[2,48,5],f32>, !torch.int, !torch.vtensor<[2,12,5],si64>, !torch.bool -> !torch.vtensor<[2,12,5],f32>
    %16 = torch.prim.ListConstruct %int4, %int3 : (!torch.int, !torch.int) -> !torch.list<int>
    %17 = torch.aten.unflatten.int %15, %int1, %16 : !torch.vtensor<[2,12,5],f32>, !torch.int, !torch.list<int> -> !torch.vtensor<[2,4,3,5],f32>
    return %17 : !torch.vtensor<[2,4,3,5],f32>
  }
}

