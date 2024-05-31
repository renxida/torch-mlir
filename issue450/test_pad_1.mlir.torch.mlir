module {
  func.func @test_pad(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[4],si64>, %arg2: !torch.vtensor<[],f32>) -> !torch.vtensor<[5,4],f32> attributes {torch.onnx_meta.opset_version = 19 : si64} {
    %str = torch.constant.str "constant"
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg2 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %2 = torch.aten.item %1 : !torch.vtensor<[],si64> -> !torch.int
    %3 = torch.aten.select.int %arg1, %int0, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %4 = torch.aten.item %3 : !torch.vtensor<[],si64> -> !torch.int
    %5 = torch.aten.select.int %arg1, %int0, %int2 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %6 = torch.aten.item %5 : !torch.vtensor<[],si64> -> !torch.int
    %7 = torch.aten.select.int %arg1, %int0, %int3 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %8 = torch.aten.item %7 : !torch.vtensor<[],si64> -> !torch.int
    %9 = torch.prim.ListConstruct %2, %6, %4, %8 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.aten.pad %arg0, %9, %str, %0 : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.str, !torch.float -> !torch.vtensor<[5,4],f32>
    return %10 : !torch.vtensor<[5,4],f32>
  }
}

