module {
  func.func @test_maxpool_pad(%arg0: !torch.vtensor<[1,64,111,111],f32>) -> !torch.vtensor<[1,64,56,56],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64} {
    %false = torch.constant.bool false
    %int0 = torch.constant.int 0
    %int3 = torch.constant.int 3
    %float-1.797690e308 = torch.constant.float -1.7976931348623157E+308
    %int1 = torch.constant.int 1
    %int2 = torch.constant.int 2
    %0 = torch.prim.ListConstruct %int1, %int1, %int2, %int2 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.constant_pad_nd %arg0, %0, %float-1.797690e308 : !torch.vtensor<[1,64,111,111],f32>, !torch.list<int>, !torch.float -> !torch.vtensor<[1,64,114,114],f32>
    %2 = torch.prim.ListConstruct %int3, %int3 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.prim.ListConstruct %int2, %int2 : (!torch.int, !torch.int) -> !torch.list<int>
    %5 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %6 = torch.aten.max_pool2d %1, %2, %4, %3, %5, %false : !torch.vtensor<[1,64,114,114],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,64,56,56],f32>
    return %6 : !torch.vtensor<[1,64,56,56],f32>
  }
}

