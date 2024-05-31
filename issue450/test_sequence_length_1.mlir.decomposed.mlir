module {
  func.func @test_sequence_length(%arg0: !torch.list<vtensor<[?,?,?],f32>>) -> !torch.vtensor<[],si64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %none = torch.constant.none
    %0 = torch.aten.len.t %arg0 : !torch.list<vtensor<[?,?,?],f32>> -> !torch.int
    %1 = torch.aten.tensor.int %0, %none, %none, %false : !torch.int, !torch.none, !torch.none, !torch.bool -> !torch.vtensor<[],si64>
    return %1 : !torch.vtensor<[],si64>
  }
}

