module {
  func.func @test_pad(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[4],si64>, %arg2: !torch.vtensor<[],f32>) -> !torch.vtensor<[5,4],f32> attributes {torch.onnx_meta.opset_version = 19 : si64} {
    %int4 = torch.constant.int 4
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg2 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.slice.Tensor %arg1, %int0, %int0, %int1, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %2 = torch.aten.squeeze.dim %1, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[],si64> -> !torch.int
    %4 = torch.aten.slice.Tensor %arg1, %int0, %int1, %int2, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %5 = torch.aten.squeeze.dim %4, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %6 = torch.aten.item %5 : !torch.vtensor<[],si64> -> !torch.int
    %7 = torch.aten.slice.Tensor %arg1, %int0, %int2, %int3, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %8 = torch.aten.squeeze.dim %7, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %9 = torch.aten.item %8 : !torch.vtensor<[],si64> -> !torch.int
    %10 = torch.aten.slice.Tensor %arg1, %int0, %int3, %int4, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %11 = torch.aten.squeeze.dim %10, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %12 = torch.aten.item %11 : !torch.vtensor<[],si64> -> !torch.int
    %13 = torch.prim.ListConstruct %3, %9, %6, %12 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %14 = torch.aten.constant_pad_nd %arg0, %13, %0 : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.float -> !torch.vtensor<[5,4],f32>
    return %14 : !torch.vtensor<[5,4],f32>
  }
}

