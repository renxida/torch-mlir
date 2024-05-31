module {
  func.func @test_expand_dim2_shape2(%arg0: !torch.vtensor<[1,4],f32>, %arg1: !torch.vtensor<[2],si32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int4 = torch.constant.int 4
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[2],si32>, !torch.int, !torch.int -> !torch.vtensor<[],si32>
    %1 = torch.aten.item %0 : !torch.vtensor<[],si32> -> !torch.int
    %2 = torch.prim.max.int %1, %int1 : !torch.int, !torch.int -> !torch.int
    %3 = torch.aten.select.int %arg1, %int0, %int1 : !torch.vtensor<[2],si32>, !torch.int, !torch.int -> !torch.vtensor<[],si32>
    %4 = torch.aten.item %3 : !torch.vtensor<[],si32> -> !torch.int
    %5 = torch.prim.max.int %4, %int4 : !torch.int, !torch.int -> !torch.int
    %6 = torch.prim.ListConstruct %2, %5 : (!torch.int, !torch.int) -> !torch.list<int>
    %7 = torch.aten.broadcast_to %arg0, %6 : !torch.vtensor<[1,4],f32>, !torch.list<int> -> !torch.vtensor<[3,4],f32>
    return %7 : !torch.vtensor<[3,4],f32>
  }
}

