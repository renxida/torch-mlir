module {
  func.func @test_argmin_no_keepdims_example_select_last_index(%arg0: !torch.vtensor<[2,2],f32>) -> !torch.vtensor<[2],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %false = torch.constant.bool false
    %0 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.flip %arg0, %0 : !torch.vtensor<[2,2],f32>, !torch.list<int> -> !torch.vtensor<[2,2],f32>
    %2 = torch.aten.argmin %1, %int1, %false : !torch.vtensor<[2,2],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2],si64>
    %3 = torch.aten.sub.Scalar %2, %int1, %int1 : !torch.vtensor<[2],si64>, !torch.int, !torch.int -> !torch.vtensor<[2],si64>
    %4 = torch.aten.abs %3 : !torch.vtensor<[2],si64> -> !torch.vtensor<[2],si64>
    return %4 : !torch.vtensor<[2],si64>
  }
}

