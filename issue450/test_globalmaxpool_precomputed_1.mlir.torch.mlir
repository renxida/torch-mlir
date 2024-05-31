module {
  func.func @test_globalmaxpool_precomputed(%arg0: !torch.vtensor<[1,1,3,3],f32>) -> !torch.vtensor<[1,1,1,1],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %0 = torch.prim.ListConstruct %int3, %int3 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.aten.max_pool2d %arg0, %0, %3, %1, %2, %false : !torch.vtensor<[1,1,3,3],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,1,1,1],f32>
    return %4 : !torch.vtensor<[1,1,1,1],f32>
  }
}

