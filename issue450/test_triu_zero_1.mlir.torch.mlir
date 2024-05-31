module {
  func.func @test_triu_zero(%arg0: !torch.vtensor<[0,5],si64>, %arg1: !torch.vtensor<[],si64>) -> !torch.vtensor<[0,5],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.item %arg1 : !torch.vtensor<[],si64> -> !torch.int
    %1 = torch.aten.triu %arg0, %0 : !torch.vtensor<[0,5],si64>, !torch.int -> !torch.vtensor<[0,5],si64>
    return %1 : !torch.vtensor<[0,5],si64>
  }
}

