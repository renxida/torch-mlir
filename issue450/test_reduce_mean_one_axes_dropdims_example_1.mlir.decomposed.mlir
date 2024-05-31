module {
  func.func @test_reduce_mean_one_axes_dropdims_example(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %int2 = torch.constant.int 2
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %false, %none : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
    %2 = torch.aten.div.Scalar %1, %int2 : !torch.vtensor<[3,2],f32>, !torch.int -> !torch.vtensor<[3,2],f32>
    return %2 : !torch.vtensor<[3,2],f32>
  }
}

