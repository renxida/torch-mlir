module {
  func.func @test_reduce_sum_negative_axes_keepdims_example(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.prim.ListConstruct %1 : (!torch.int) -> !torch.list<int>
    %3 = torch.aten.sum.dim_IntList %arg0, %2, %true, %none : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,1,2],f32>
    return %3 : !torch.vtensor<[3,1,2],f32>
  }
}

