module {
  func.func @test_logsoftmax_old_axis_1_dynamic_dim(%arg0: !torch.vtensor<[3,4,?],f32>) -> !torch.vtensor<[3,4,?],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %none = torch.constant.none
    %int2 = torch.constant.int 2
    %int4 = torch.constant.int 4
    %int-1 = torch.constant.int -1
    %0 = torch.prim.ListConstruct %int4, %int-1 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.flatten.using_ints %arg0, %int1, %int2 : !torch.vtensor<[3,4,?],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,?],f32>
    %2 = torch.aten.log_softmax.int %1, %int1, %none : !torch.vtensor<[3,?],f32>, !torch.int, !torch.none -> !torch.vtensor<[3,?],f32>
    %3 = torch.aten.unflatten.int %2, %int1, %0 : !torch.vtensor<[3,?],f32>, !torch.int, !torch.list<int> -> !torch.vtensor<[3,4,?],f32>
    return %3 : !torch.vtensor<[3,4,?],f32>
  }
}

