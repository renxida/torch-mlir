module {
  func.func @test_tril_square(%arg0: !torch.vtensor<[2,3,3],si64>) -> !torch.vtensor<[2,3,3],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %0 = torch.aten.tril %arg0, %int0 : !torch.vtensor<[2,3,3],si64>, !torch.int -> !torch.vtensor<[2,3,3],si64>
    return %0 : !torch.vtensor<[2,3,3],si64>
  }
}

