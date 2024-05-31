module {
  func.func @test_reduce_l2_do_not_keepdims_example_expanded(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int0 = torch.constant.int 0
    %0 = torch.aten.mul.Tensor %arg0, %arg0 : !torch.vtensor<[3,2,2],f32>, !torch.vtensor<[3,2,2],f32> -> !torch.vtensor<[3,2,2],f32>
    %1 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %2 = torch.aten.item %1 : !torch.vtensor<[1],si64> -> !torch.int
    %3 = torch.prim.ListConstruct %2 : (!torch.int) -> !torch.list<int>
    %4 = torch.aten.sum.dim_IntList %0, %3, %false, %none : !torch.vtensor<[3,2,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
    %5 = torch.aten.sqrt %4 : !torch.vtensor<[3,2],f32> -> !torch.vtensor<[3,2],f32>
    return %5 : !torch.vtensor<[3,2],f32>
  }
}

