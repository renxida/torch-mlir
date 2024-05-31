

// CHECK-LABEL: @test_matmulinteger_batched
func.func @test_matmulinteger_batched(%arg0: !torch.vtensor<[7,4,3],ui8>, %arg1: !torch.vtensor<[3,2],ui8>, %arg2: !torch.vtensor<[1],ui8>, %arg3: !torch.vtensor<[1],ui8>) -> !torch.vtensor<[7,4,2],si32> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 10 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  %0 = torch.operator "onnx.MatMulInteger"(%arg0, %arg1, %arg2, %arg3) : (!torch.vtensor<[7,4,3],ui8>, !torch.vtensor<[3,2],ui8>, !torch.vtensor<[1],ui8>, !torch.vtensor<[1],ui8>) -> !torch.vtensor<[7,4,2],si32>
  // CHECK: %[[LITEM:.+]] = torch.aten.item %arg2
  // CHECK: %[[RITEM:.+]] = torch.aten.item %arg3
  // CHECK: %[[SCALE:.+]] = torch.constant.float 1.000000e+00
  // CHECK: %[[LMAKE:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg0, %[[SCALE]], %[[LITEM]] : !torch.vtensor<[7,4,3],ui8>, !torch.float, !torch.int -> !torch.vtensor<[7,4,3],!torch.quint8>
  // CHECK: %[[RMAKE:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg1, %[[SCALE]], %[[RITEM]] : !torch.vtensor<[3,2],ui8>, !torch.float, !torch.int -> !torch.vtensor<[3,2],!torch.quint8>
  // CHECK: %[[MM:.+]] = torch.aten.matmul %[[LMAKE]], %[[RMAKE]]
  // CHECK: return %[[MM]]
  return %0 : !torch.vtensor<[7,4,2],si32>
}
