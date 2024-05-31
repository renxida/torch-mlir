module {
  func.func @test_eyelike_diagonal(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %0 = torch.aten.eye.m %int3, %int3, %int6, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,3],f32>
    %1 = torch.prim.ListConstruct %int3, %int4 : (!torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.aten.zeros %1, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,4],f32>
    %3 = torch.aten.slice_scatter %2, %0, %int1, %int1, %int4, %int1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,3],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,4],f32>
    return %3 : !torch.vtensor<[3,4],f32>
  }
}

