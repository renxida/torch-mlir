module {
  func.func @test_reduce_mean_do_not_keepdims_example(%arg0: !torch.vtensor<[3,2,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int4 = torch.constant.int 4
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int2 = torch.constant.int 2
    %0 = torch.prim.ListConstruct %int2 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %false, %none : !torch.vtensor<[3,2,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
    %2 = torch.aten.div.Scalar %1, %int4 : !torch.vtensor<[3,2],f32>, !torch.int -> !torch.vtensor<[3,2],f32>
    return %2 : !torch.vtensor<[3,2],f32>
  }
}

