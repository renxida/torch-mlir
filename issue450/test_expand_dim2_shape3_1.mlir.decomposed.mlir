module {
  func.func @test_expand_dim2_shape3(%arg0: !torch.vtensor<[3,1],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,3,6],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int3 = torch.constant.int 3
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.slice.Tensor %arg1, %int0, %int0, %int1, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.squeeze.dim %0, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %2 = torch.aten.item %1 : !torch.vtensor<[],si64> -> !torch.int
    %3 = torch.aten.slice.Tensor %arg1, %int0, %int1, %int2, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %4 = torch.aten.squeeze.dim %3, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %5 = torch.aten.item %4 : !torch.vtensor<[],si64> -> !torch.int
    %6 = torch.prim.max.int %5, %int3 : !torch.int, !torch.int -> !torch.int
    %7 = torch.aten.slice.Tensor %arg1, %int0, %int2, %int3, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %8 = torch.aten.squeeze.dim %7, %int0 : !torch.vtensor<[1],si64>, !torch.int -> !torch.vtensor<[],si64>
    %9 = torch.aten.item %8 : !torch.vtensor<[],si64> -> !torch.int
    %10 = torch.prim.max.int %9, %int1 : !torch.int, !torch.int -> !torch.int
    %11 = torch.prim.ListConstruct %2, %6, %10 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %12 = torch.aten.broadcast_to %arg0, %11 : !torch.vtensor<[3,1],f32>, !torch.list<int> -> !torch.vtensor<[2,3,6],f32>
    return %12 : !torch.vtensor<[2,3,6],f32>
  }
}

