module {
  func.func @test_pad_optional_constant(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[5,4],f32> attributes {torch.onnx_meta.opset_version = 19 : si64} {
    %str = torch.constant.str "constant"
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[],si64> -> !torch.int
    %2 = torch.aten.select.int %arg1, %int0, %int1 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[],si64> -> !torch.int
    %4 = torch.aten.select.int %arg1, %int0, %int2 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %5 = torch.aten.item %4 : !torch.vtensor<[],si64> -> !torch.int
    %6 = torch.aten.select.int %arg1, %int0, %int3 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %7 = torch.aten.item %6 : !torch.vtensor<[],si64> -> !torch.int
    %8 = torch.prim.ListConstruct %1, %5, %3, %7 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %9 = torch.aten.pad %arg0, %8, %str, %float0.000000e00 : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.str, !torch.float -> !torch.vtensor<[5,4],f32>
    return %9 : !torch.vtensor<[5,4],f32>
  }
}

