module {
  func.func @test_einsum_sum(%arg0: !torch.vtensor<[3,4],f64>) -> !torch.vtensor<[3],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %str = torch.constant.str "ij->i"
    %0 = torch.prim.ListConstruct %arg0 : (!torch.vtensor<[3,4],f64>) -> !torch.list<vtensor>
    %1 = torch.aten.einsum %str, %0, %none : !torch.str, !torch.list<vtensor>, !torch.none -> !torch.vtensor<[3],f64>
    return %1 : !torch.vtensor<[3],f64>
  }
}

