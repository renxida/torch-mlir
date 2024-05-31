module {
  func.func @test_pad_optional_constant(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[5,4],f32> attributes {torch.onnx_meta.opset_version = 19 : si64} {
    %int4 = torch.constant.int 4
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.aten.slice.Tensor %arg1, %int0, %int0, %int1, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.squeeze.dim %0, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %2 = torch.aten.item %1 : !torch.vtensor<[],si64> -> !torch.int
    %3 = torch.aten.slice.Tensor %arg1, %int0, %int1, %int2, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %4 = torch.aten.squeeze.dim %3, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %5 = torch.aten.item %4 : !torch.vtensor<[],si64> -> !torch.int
    %6 = torch.aten.slice.Tensor %arg1, %int0, %int2, %int3, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %7 = torch.aten.squeeze.dim %6, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %8 = torch.aten.item %7 : !torch.vtensor<[],si64> -> !torch.int
    %9 = torch.aten.slice.Tensor %arg1, %int0, %int3, %int4, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %10 = torch.aten.squeeze.dim %9, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %11 = torch.aten.item %10 : !torch.vtensor<[],si64> -> !torch.int
    %12 = torch.prim.ListConstruct %2, %8, %5, %11 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %13 = torch.aten.constant_pad_nd %arg0, %12, %float0.000000e00 : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.float -> !torch.vtensor<[5,4],f32>
    return %13 : !torch.vtensor<[5,4],f32>
  }
}

