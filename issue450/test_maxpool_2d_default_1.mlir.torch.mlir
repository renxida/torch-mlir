module {
  func.func @test_maxpool_2d_default(%arg0: !torch.vtensor<[1,3,32,32],f32>) -> !torch.vtensor<[1,3,31,31],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64} {
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %int2 = torch.constant.int 2
    %0 = torch.prim.ListConstruct %int2, %int2 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.aten.max_pool2d %arg0, %0, %2, %1, %3, %false : !torch.vtensor<[1,3,32,32],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,3,31,31],f32>
    return %4 : !torch.vtensor<[1,3,31,31],f32>
  }
}

