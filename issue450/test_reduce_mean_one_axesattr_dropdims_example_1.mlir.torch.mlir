module {
  func.func @test_reduce_mean_one_axesattr_dropdims_example(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.mean.dim %arg0, %0, %false, %none : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
    return %1 : !torch.vtensor<[3,2],f32>
  }
}

