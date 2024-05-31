module {
  func.func @test_reduce_mean_all_dims_keepdims_example(%arg0: !torch.vtensor<[3,2,4],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[1,1,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int24 = torch.constant.int 24
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %int2 = torch.constant.int 2
    %0 = torch.prim.ListConstruct %int0, %int1, %int2 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %true, %none : !torch.vtensor<[3,2,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f32>
    %2 = torch.aten.div.Scalar %1, %int24 : !torch.vtensor<[1,1,1],f32>, !torch.int -> !torch.vtensor<[1,1,1],f32>
    return %2 : !torch.vtensor<[1,1,1],f32>
  }
}

