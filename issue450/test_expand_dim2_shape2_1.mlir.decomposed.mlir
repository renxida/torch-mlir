module {
  func.func @test_expand_dim2_shape2(%arg0: !torch.vtensor<[1,4],f32>, %arg1: !torch.vtensor<[2],si32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int4 = torch.constant.int 4
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.slice.Tensor %arg1, %int0, %int0, %int1, %int1 : !torch.vtensor<[2],si32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si32>
    %1 = torch.aten.squeeze.dim %0, %int0 : !torch.vtensor<[1],si32>, !torch.int -> !torch.vtensor<[],si32>
    %2 = torch.aten.item %1 : !torch.vtensor<[],si32> -> !torch.int
    %3 = torch.prim.max.int %2, %int1 : !torch.int, !torch.int -> !torch.int
    %4 = torch.aten.slice.Tensor %arg1, %int0, %int1, %int2, %int1 : !torch.vtensor<[2],si32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si32>
    %5 = torch.aten.squeeze.dim %4, %int0 : !torch.vtensor<[1],si32>, !torch.int -> !torch.vtensor<[],si32>
    %6 = torch.aten.item %5 : !torch.vtensor<[],si32> -> !torch.int
    %7 = torch.prim.max.int %6, %int4 : !torch.int, !torch.int -> !torch.int
    %8 = torch.prim.ListConstruct %3, %7 : (!torch.int, !torch.int) -> !torch.list<int>
    %9 = torch.aten.broadcast_to %arg0, %8 : !torch.vtensor<[1,4],f32>, !torch.list<int> -> !torch.vtensor<[3,4],f32>
    return %9 : !torch.vtensor<[3,4],f32>
  }
}

