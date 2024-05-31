module {
  func.func @test_reduce_log_sum_keep_dims_example(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %0 = torch.aten.item %arg1 : !torch.vtensor<[1],si64> -> !torch.int
    %1 = torch.prim.ListConstruct %0 : (!torch.int) -> !torch.list<int>
    %2 = torch.aten.sum.dim_IntList %arg0, %1, %true, %none : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2,1],f32>
    %3 = torch.aten.log %2 : !torch.vtensor<[3,2,1],f32> -> !torch.vtensor<[3,2,1],f32>
    return %3 : !torch.vtensor<[3,2,1],f32>
  }
}

