module {
  func.func @test_reduce_mean_keepdims_example(%arg0: !torch.vtensor<[3,2,4,5,1,6,7],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[3,1,4,1,1,6,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %int6 = torch.constant.int 6
    %0 = torch.prim.ListConstruct %int1, %int3, %int6 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.mean.dim %arg0, %0, %true, %none : !torch.vtensor<[3,2,4,5,1,6,7],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,1,4,1,1,6,1],f32>
    return %1 : !torch.vtensor<[3,1,4,1,1,6,1],f32>
  }
}

