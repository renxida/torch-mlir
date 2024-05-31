module {
  func.func @test_reduce_min_empty_set_fp(%arg0: !torch.vtensor<[2,0,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,1,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %floatInf = torch.constant.float 0x7FF0000000000000
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int4 = torch.constant.int 4
    %none = torch.constant.none
    %0 = torch.prim.ListConstruct %int2, %int1, %int4 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.full %0, %floatInf, %none, %none, %none, %none : !torch.list<int>, !torch.float, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2,1,4],f32>
    return %1 : !torch.vtensor<[2,1,4],f32>
  }
}

