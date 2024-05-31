module {
  func.func @test_einsum_sum(%arg0: !torch.vtensor<[3,4],f64>) -> !torch.vtensor<[3],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %false, %none : !torch.vtensor<[3,4],f64>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<*,f64>
    %2 = torch.prim.ListConstruct %int0 : (!torch.int) -> !torch.list<int>
    %3 = torch.aten.permute %1, %2 : !torch.vtensor<*,f64>, !torch.list<int> -> !torch.vtensor<[3],f64>
    return %3 : !torch.vtensor<[3],f64>
  }
}

