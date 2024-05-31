module {
  func.func @test_split_variable_parts_2d_opset18(%arg0: !torch.vtensor<[2,6],f32>, %arg1: !torch.vtensor<[2],si64>) -> (!torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>) attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.prim.tolist(%arg1) : !torch.vtensor<[2],si64> -> !torch.list<int>
    %1 = torch.aten.split_with_sizes %arg0, %0, %int1 : !torch.vtensor<[2,6],f32>, !torch.list<int>, !torch.int -> !torch.list<vtensor<[2,?],f32>>
    %2:2 = torch.prim.ListUnpack %1 : !torch.list<vtensor<[2,?],f32>> -> !torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>
    return %2#0, %2#1 : !torch.vtensor<[2,2],f32>, !torch.vtensor<[2,4],f32>
  }
}

