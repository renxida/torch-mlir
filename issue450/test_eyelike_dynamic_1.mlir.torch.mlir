module {
  func.func @test_eyelike_dynamic(%arg0: !torch.vtensor<[3,?],f32>) -> !torch.vtensor<[3,?],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %0 = torch.aten.size.int %arg0, %int1 : !torch.vtensor<[3,?],f32>, !torch.int -> !torch.int
    %1 = torch.aten.eye.m %int2, %0, %int6, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2,?],f32>
    %2 = torch.prim.ListConstruct %int3, %0 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.aten.zeros %2, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,?],f32>
    %4 = torch.aten.slice_scatter %3, %1, %int0, %int1, %int3, %int1 : !torch.vtensor<[3,?],f32>, !torch.vtensor<[2,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,?],f32>
    return %4 : !torch.vtensor<[3,?],f32>
  }
}

