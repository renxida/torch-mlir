module {
  func.func @test_argmin_negative_axis_keepdims_random_select_last_index(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,3,1],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %true = torch.constant.bool true
    %0 = torch.prim.ListConstruct %int2 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.flip %arg0, %0 : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,3,4],f32>
    %2 = torch.aten.argmin %1, %int2, %true : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2,3,1],si64>
    %3 = torch.aten.sub.Scalar %2, %int3, %int1 : !torch.vtensor<[2,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,3,1],si64>
    %4 = torch.aten.abs %3 : !torch.vtensor<[2,3,1],si64> -> !torch.vtensor<[2,3,1],si64>
    return %4 : !torch.vtensor<[2,3,1],si64>
  }
}

