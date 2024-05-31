module {
  func.func @test_celu(%arg0: !torch.vtensor<[3,3,3,1],f32>) -> !torch.vtensor<[3,3,3,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %0 = torch.aten.div.Scalar %arg0, %float2.000000e00 : !torch.vtensor<[3,3,3,1],f32>, !torch.float -> !torch.vtensor<[3,3,3,1],f32>
    %1 = torch.aten.exp %0 : !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
    %2 = torch.aten.sub.Scalar %1, %int1, %int1 : !torch.vtensor<[3,3,3,1],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,3,3,1],f32>
    %3 = torch.aten.mul.Scalar %2, %float2.000000e00 : !torch.vtensor<[3,3,3,1],f32>, !torch.float -> !torch.vtensor<[3,3,3,1],f32>
    %4 = torch.prim.ListConstruct  : () -> !torch.list<int>
    %5 = torch.aten.full %4, %int0, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
    %6 = torch.aten.minimum %5, %3 : !torch.vtensor<[],f32>, !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
    %7 = torch.aten.maximum %5, %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
    %8 = torch.aten.add.Tensor %7, %6, %int1 : !torch.vtensor<[3,3,3,1],f32>, !torch.vtensor<[3,3,3,1],f32>, !torch.int -> !torch.vtensor<[3,3,3,1],f32>
    return %8 : !torch.vtensor<[3,3,3,1],f32>
  }
}

