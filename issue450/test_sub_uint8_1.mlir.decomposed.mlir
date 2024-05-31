module {
  func.func @test_sub_uint8(%arg0: !torch.vtensor<[3,4,5],ui8>, %arg1: !torch.vtensor<[3,4,5],ui8>) -> !torch.vtensor<[3,4,5],ui8> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.aten.sub.Tensor %arg0, %arg1, %int1 : !torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[3,4,5],ui8>, !torch.int -> !torch.vtensor<[3,4,5],ui8>
    return %0 : !torch.vtensor<[3,4,5],ui8>
  }
}

