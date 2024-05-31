module {
  func.func @test_dequantizelinear_ui8(%arg0: !torch.vtensor<[6],ui8>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],ui8>) -> !torch.vtensor<[6],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64} {
    %0 = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.item %arg2 : !torch.vtensor<[],ui8> -> !torch.int
    %2 = torch.aten._make_per_tensor_quantized_tensor %arg0, %0, %1 : !torch.vtensor<[6],ui8>, !torch.float, !torch.int -> !torch.vtensor<[6],!torch.quint8>
    %3 = torch.aten.dequantize.self %2 : !torch.vtensor<[6],!torch.quint8> -> !torch.vtensor<[6],f32>
    return %3 : !torch.vtensor<[6],f32>
  }
}

