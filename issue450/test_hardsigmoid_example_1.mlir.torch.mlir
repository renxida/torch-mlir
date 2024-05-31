module {
  func.func @test_hardsigmoid_example(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %float5.000000e-01 = torch.constant.float 5.000000e-01
    %float6.000000e-01 = torch.constant.float 0.60000002384185791
    %0 = torch.aten.add.Scalar %arg0, %float6.000000e-01, %float5.000000e-01 : !torch.vtensor<[3],f32>, !torch.float, !torch.float -> !torch.vtensor<[3],f32>
    %1 = torch.prim.ListConstruct  : () -> !torch.list<int>
    %2 = torch.aten.full %1, %int1, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
    %3 = torch.aten.minimum %2, %0 : !torch.vtensor<[],f32>, !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    %4 = torch.prim.ListConstruct  : () -> !torch.list<int>
    %5 = torch.aten.full %4, %int0, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
    %6 = torch.aten.maximum %5, %3 : !torch.vtensor<[],f32>, !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
    return %6 : !torch.vtensor<[3],f32>
  }
}

