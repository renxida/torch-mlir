module {
  func.func @test_random_normal() -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float6.283180e00 = torch.constant.float 6.283180e+00
    %float-2.000000e00 = torch.constant.float -2.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %none = torch.constant.none
    %int6 = torch.constant.int 6
    %int10 = torch.constant.int 10
    %0 = torch.prim.ListConstruct %int10 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.empty.memory_format %0, %int6, %none, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
    %2 = torch.prim.ListConstruct %int10 : (!torch.int) -> !torch.list<int>
    %3 = torch.aten.empty.memory_format %2, %int6, %none, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
    %4 = torch.aten.empty.memory_format %2, %int6, %none, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
    %5 = torch.aten.uniform %3, %float0.000000e00, %float1.000000e00, %none : !torch.vtensor<[10],f32>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f32>
    %6 = torch.aten.uniform %4, %float0.000000e00, %float1.000000e00, %none : !torch.vtensor<[10],f32>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f32>
    %7 = torch.aten.log %5 : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
    %8 = torch.aten.mul.Scalar %7, %float-2.000000e00 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %9 = torch.aten.sqrt %8 : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
    %10 = torch.aten.mul.Scalar %6, %float6.283180e00 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %11 = torch.aten.cos %10 : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
    %12 = torch.aten.mul.Tensor %9, %11 : !torch.vtensor<[10],f32>, !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
    %13 = torch.aten.mul.Scalar %12, %float1.000000e00 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %14 = torch.aten.add.Scalar %13, %float0.000000e00, %float1.000000e00 : !torch.vtensor<[10],f32>, !torch.float, !torch.float -> !torch.vtensor<[10],f32>
    return %14 : !torch.vtensor<[10],f32>
  }
}

