module {
  func.func @test_random_normal() -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %none = torch.constant.none
    %int6 = torch.constant.int 6
    %int10 = torch.constant.int 10
    %0 = torch.prim.ListConstruct %int10 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.empty.memory_format %0, %int6, %none, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
    %2 = torch.aten.normal_functional %1, %float0.000000e00, %float1.000000e00, %none : !torch.vtensor<[10],f32>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f32>
    return %2 : !torch.vtensor<[10],f32>
  }
}

