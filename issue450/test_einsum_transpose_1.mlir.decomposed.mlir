module {
  func.func @test_einsum_transpose(%arg0: !torch.vtensor<[3,4],f64>) -> !torch.vtensor<[4,3],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.prim.ListConstruct %int1, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.permute %arg0, %0 : !torch.vtensor<[3,4],f64>, !torch.list<int> -> !torch.vtensor<[4,3],f64>
    return %1 : !torch.vtensor<[4,3],f64>
  }
}

