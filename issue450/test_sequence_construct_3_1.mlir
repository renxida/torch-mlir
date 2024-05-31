

// CHECK-LABEL: func.func @test_sequence_construct_3
module {
  func.func @test_sequence_construct_3(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[2,3,4],f32>, %arg2: !torch.vtensor<[2,3,4],f32>) -> !torch.list<vtensor<[2,3,4],f32>> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
// CHECK: %[[SEQ:.+]] = torch.prim.ListConstruct %arg0, %arg1, %arg2 : (!torch.vtensor<[2,3,4],f32>, !torch.vtensor<[2,3,4],f32>, !torch.vtensor<[2,3,4],f32>) -> !torch.list<vtensor<[2,3,4],f32>>
// CHECK: return %[[SEQ]] : !torch.list<vtensor<[2,3,4],f32>>
    %0 = torch.operator "onnx.SequenceConstruct"(%arg0, %arg1, %arg2) : (!torch.vtensor<[2,3,4],f32>, !torch.vtensor<[2,3,4],f32>, !torch.vtensor<[2,3,4],f32>) -> !torch.list<vtensor<[2,3,4],f32>>
    return %0 : !torch.list<vtensor<[2,3,4],f32>>
  }
}

