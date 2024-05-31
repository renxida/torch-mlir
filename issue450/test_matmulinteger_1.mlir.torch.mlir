module {
  func.func @test_matmulinteger(%arg0: !torch.vtensor<[4,3],ui8>, %arg1: !torch.vtensor<[3,2],ui8>, %arg2: !torch.vtensor<[1],ui8>, %arg3: !torch.vtensor<[1],ui8>) -> !torch.vtensor<[4,2],si32> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 10 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.aten.item %arg2 : !torch.vtensor<[1],ui8> -> !torch.int
    %1 = torch.aten.item %arg3 : !torch.vtensor<[1],ui8> -> !torch.int
    %2 = torch.aten._make_per_tensor_quantized_tensor %arg0, %float1.000000e00, %0 : !torch.vtensor<[4,3],ui8>, !torch.float, !torch.int -> !torch.vtensor<[4,3],!torch.quint8>
    %3 = torch.aten._make_per_tensor_quantized_tensor %arg1, %float1.000000e00, %1 : !torch.vtensor<[3,2],ui8>, !torch.float, !torch.int -> !torch.vtensor<[3,2],!torch.quint8>
    %4 = torch.aten.matmul %2, %3 : !torch.vtensor<[4,3],!torch.quint8>, !torch.vtensor<[3,2],!torch.quint8> -> !torch.vtensor<[4,2],si32>
    return %4 : !torch.vtensor<[4,2],si32>
  }
}

