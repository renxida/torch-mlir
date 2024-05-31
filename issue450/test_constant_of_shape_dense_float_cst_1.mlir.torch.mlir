module {
  func.func @test_constant_of_shape_dense_float_cst() -> !torch.vtensor<[2,3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float3.400000e00 = torch.constant.float 3.4000000953674316
    %none = torch.constant.none
    %int2 = torch.constant.int 2
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %0 = torch.prim.ListConstruct %int2, %int3, %int4 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.full %0, %float3.400000e00, %none, %none, %none, %none : !torch.list<int>, !torch.float, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2,3,4],f32>
    return %1 : !torch.vtensor<[2,3,4],f32>
  }
}

