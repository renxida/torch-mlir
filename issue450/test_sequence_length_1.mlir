

// CHECK-LABEL: func.func @test_sequence_length
module {
  func.func @test_sequence_length(%arg0: !torch.list<vtensor<[?,?,?],f32>>) ->  !torch.vtensor<[],si64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
// CHECK: %[[FALSE:.+]] = torch.constant.bool false
// CHECK: %[[NONE:.+]] = torch.constant.none
// CHECK: %[[LEN:.+]] = torch.aten.len.t %arg0 : !torch.list<vtensor<[?,?,?],f32>> -> !torch.int
// CHECK: %[[LEN_AS_TEN:.+]] = torch.aten.tensor.int %[[LEN]],  %[[NONE]],  %[[NONE]], %[[FALSE]] : !torch.int, !torch.none, !torch.none, !torch.bool -> !torch.vtensor<[],si64>
// CHECK: return %[[LEN_AS_TEN]] : !torch.vtensor<[],si64>
    %0 = torch.operator "onnx.SequenceLength"(%arg0) : (!torch.list<vtensor<[?,?,?],f32>>) -> !torch.vtensor<[],si64>
    return %0 : !torch.vtensor<[],si64>
  }
}

