module {
  func.func @test_averagepool_with_padding(%arg0: !torch.vtensor<[1,20,64,48],f32>) -> !torch.vtensor<[1,20,32,24],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 19 : si64} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int2 = torch.constant.int 2
    %int0 = torch.constant.int 0
    %0 = torch.prim.ListConstruct %int2, %int2 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prim.ListConstruct %int0, %int0, %int0, %int0 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.prim.ListConstruct %int2, %int2 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.aten.avg_pool2d %arg0, %0, %2, %1, %false, %false, %none : !torch.vtensor<[1,20,64,48],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[1,20,32,24],f32>
    return %3 : !torch.vtensor<[1,20,32,24],f32>
  }
}

