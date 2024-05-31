module {
  func.func @test_reduce_min_attr(%arg0: !torch.vtensor<[4,2],i1>) -> !torch.vtensor<[4],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %values, %indices = torch.aten.min.dim %arg0, %int1, %false : !torch.vtensor<[4,2],i1>, !torch.int, !torch.bool -> !torch.vtensor<[4],i1>, !torch.vtensor<[4],si32>
    return %values : !torch.vtensor<[4],i1>
  }
}

