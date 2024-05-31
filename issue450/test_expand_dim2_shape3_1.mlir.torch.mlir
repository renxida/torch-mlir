module {
  func.func @test_expand_dim2_shape3(%arg0: !torch.vtensor<[3,1],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,3,6],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[],si64> -> !torch.int
    %2 = torch.aten.select.int %arg1, %int0, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[],si64> -> !torch.int
    %4 = torch.prim.max.int %3, %int3 : !torch.int, !torch.int -> !torch.int
    %5 = torch.aten.select.int %arg1, %int0, %int2 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %6 = torch.aten.item %5 : !torch.vtensor<[],si64> -> !torch.int
    %7 = torch.prim.max.int %6, %int1 : !torch.int, !torch.int -> !torch.int
    %8 = torch.prim.ListConstruct %1, %4, %7 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %9 = torch.aten.broadcast_to %arg0, %8 : !torch.vtensor<[3,1],f32>, !torch.list<int> -> !torch.vtensor<[2,3,6],f32>
    return %9 : !torch.vtensor<[2,3,6],f32>
  }
}

