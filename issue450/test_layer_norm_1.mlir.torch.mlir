module {
  func.func @test_layer_norm(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[3,4],f32>, %arg2: !torch.vtensor<[3,4],f32>) -> (!torch.vtensor<[3,4],f32>, !torch.vtensor<[1,1],f32>, !torch.vtensor<[1,1],f32>) attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float9.999990e-06 = torch.constant.float 9.9999997473787516E-6
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %0 = torch.prim.ListConstruct %int3, %int4 : (!torch.int, !torch.int) -> !torch.list<int>
    %result0, %result1, %result2 = torch.aten.native_layer_norm %arg0, %0, %arg1, %arg2, %float9.999990e-06 : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32>, !torch.float -> !torch.vtensor<[3,4],f32>, !torch.vtensor<[1,1],f32>, !torch.vtensor<[1,1],f32>
    return %result0, %result1, %result2 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[1,1],f32>, !torch.vtensor<[1,1],f32>
  }
}

