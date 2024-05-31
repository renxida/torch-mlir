module {
  func.func @test_reduce_mean_negative_axes_keepdims_example(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,1,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %int2 = torch.constant.int 2
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int-2 = torch.constant.int -2
    %0 = torch.prim.ListConstruct %int-2 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %true, %none : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,1,2],f32>
    %2 = torch.aten.div.Scalar %1, %int2 : !torch.vtensor<[3,1,2],f32>, !torch.int -> !torch.vtensor<[3,1,2],f32>
    return %2 : !torch.vtensor<[3,1,2],f32>
  }
}

