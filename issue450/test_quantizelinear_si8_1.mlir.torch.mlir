module {
  func.func @test_quantizelinear_si8(%arg0: !torch.vtensor<[6],f32>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],si8>) -> !torch.vtensor<[6],si8> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64} {
    %int12 = torch.constant.int 12
    %0 = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.item %arg2 : !torch.vtensor<[],si8> -> !torch.int
    %2 = torch.aten.quantize_per_tensor %arg0, %0, %1, %int12 : !torch.vtensor<[6],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[6],!torch.qint8>
    %3 = torch.aten.int_repr %2 : !torch.vtensor<[6],!torch.qint8> -> !torch.vtensor<[6],si8>
    return %3 : !torch.vtensor<[6],si8>
  }
}

