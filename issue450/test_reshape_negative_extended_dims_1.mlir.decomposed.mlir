module {
  func.func @test_reshape_negative_extended_dims(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[1,2,3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int2 = torch.constant.int 2
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %0 = torch.prim.ListConstruct %int1, %int2, %int3, %int4 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.view %arg0, %0 : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[1,2,3,4],f32>
    return %1 : !torch.vtensor<[1,2,3,4],f32>
  }
}

