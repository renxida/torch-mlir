module {
  func.func @test_averagepool_3d_default(%arg0: !torch.vtensor<[1,3,32,32,32],f32>) -> !torch.vtensor<[1,3,31,31,31],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int2 = torch.constant.int 2
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int2, %int2, %int2 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prim.ListConstruct %int0, %int0, %int0, %int0, %int0, %int0 : (!torch.int, !torch.int, !torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.prim.ListConstruct %int1, %int1, %int1 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.aten.avg_pool3d %arg0, %0, %2, %1, %false, %false, %none : !torch.vtensor<[1,3,32,32,32],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[1,3,31,31,31],f32>
    return %3 : !torch.vtensor<[1,3,31,31,31],f32>
  }
}

