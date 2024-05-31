module {
  func.func @test_reduce_sum_square_empty_set_non_reduced_axis_zero(%arg0: !torch.vtensor<[2,0,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,0,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int2 = torch.constant.int 2
    %0 = torch.aten.mul.Tensor %arg0, %arg0 : !torch.vtensor<[2,0,4],f32>, !torch.vtensor<[2,0,4],f32> -> !torch.vtensor<[2,0,4],f32>
    %1 = torch.prim.ListConstruct %int2 : (!torch.int) -> !torch.list<int>
    %2 = torch.aten.sum.dim_IntList %0, %1, %true, %none : !torch.vtensor<[2,0,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[2,0,1],f32>
    return %2 : !torch.vtensor<[2,0,1],f32>
  }
}

