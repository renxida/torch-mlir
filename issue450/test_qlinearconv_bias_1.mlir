

// CHECK-LABEL: @test_qlinearconv_bias
func.func @test_qlinearconv_bias(%arg0: !torch.vtensor<[1,1,7,7],ui8>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],ui8>, %arg3: !torch.vtensor<[1,1,1,1],ui8>, %arg4: !torch.vtensor<[1],f32>, %arg5: !torch.vtensor<[1],ui8>, %arg6: !torch.vtensor<[],f32>, %arg7: !torch.vtensor<[],ui8>, %arg8 : !torch.vtensor<[7],si32>) -> !torch.vtensor<[1,1,7,7],ui8> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 10 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  %0 = torch.operator "onnx.QLinearConv"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7, %arg8) : (!torch.vtensor<[1,1,7,7],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>, !torch.vtensor<[1,1,1,1],ui8>, !torch.vtensor<[1],f32>, !torch.vtensor<[1],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>, !torch.vtensor<[7],si32>) -> !torch.vtensor<[1,1,7,7],ui8>
  // CHECK: %[[aZp:.+]] = torch.aten.item %arg2 : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK: %[[bZp:.+]] = torch.aten.item %arg5 : !torch.vtensor<[1],ui8> -> !torch.int
  // CHECK: %[[cZp:.+]] = torch.aten.item %arg7 : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK: %[[aScale:.+]] = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[bScale:.+]] = torch.aten.item %arg4 : !torch.vtensor<[1],f32> -> !torch.float
  // CHECK: %[[cScale:.+]] = torch.aten.item %arg6 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[A:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg0, %[[aScale]], %[[aZp]] : !torch.vtensor<[1,1,7,7],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.quint8>
  // CHECK: %[[B:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg3, %[[bScale]], %[[bZp]] : !torch.vtensor<[1,1,1,1],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,1,1],!torch.quint8>
  // CHECK: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK: %[[INT0_1:.+]] = torch.constant.int 0
  // CHECK: %[[INT1_0:.+]] = torch.constant.int 1
  // CHECK: %[[INT1_1:.+]] = torch.constant.int 1
  // CHECK: %[[INT1_2:.+]] = torch.constant.int 1
  // CHECK: %[[INT1_3:.+]] = torch.constant.int 1
  // CHECK: %[[INT0_2:.+]] = torch.constant.int 0
  // CHECK: %[[PAD:.+]] = torch.prim.ListConstruct %[[INT0_0]], %[[INT0_1]]
  // CHECK: %[[KERNEL:.+]] = torch.prim.ListConstruct %[[INT1_0]], %[[INT1_1]]
  // CHECK: %[[DILATION:.+]] = torch.prim.ListConstruct %[[INT1_2]], %[[INT1_3]]
  // CHECK: %[[STRIDE:.+]] = torch.prim.ListConstruct %[[INT0_2]], %[[INT0_2]]
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[INT1_5:.+]] = torch.constant.int 1
  // CHECK: %[[CONV:.+]] = torch.aten.convolution %[[A]], %[[B]], %arg8, %[[DILATION]], %[[PAD]], %[[KERNEL]], %[[FALSE]], %[[STRIDE]], %[[INT1_5]] : !torch.vtensor<[1,1,7,7],!torch.quint8>, !torch.vtensor<[1,1,1,1],!torch.quint8>, !torch.vtensor<[7],si32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.qint32>
  // CHECK: %[[convScale:.+]] = torch.aten.mul.float %[[aScale]], %[[bScale]] : !torch.float, !torch.float -> !torch.float
  // CHECK: %[[INT0_6:.+]] = torch.constant.int 0
  // CHECK: %[[C:.+]] = torch.aten._make_per_tensor_quantized_tensor %[[CONV]], %[[convScale]], %[[INT0_6]] : !torch.vtensor<[1,1,7,7],!torch.qint32>, !torch.float, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.qint32>
  // CHECK: %[[DEQ:.+]] = torch.aten.dequantize.self %[[C]] : !torch.vtensor<[1,1,7,7],!torch.qint32> -> !torch.vtensor<[1,1,7,7],f32>
  // CHECK: %[[INT13:.+]] = torch.constant.int 13
  // CHECK: %[[QUANT:.+]] = torch.aten.quantize_per_tensor %[[DEQ]], %[[cScale]], %[[cZp]], %[[INT13]] : !torch.vtensor<[1,1,7,7],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.quint8>
  // CHECK: %[[INT:.+]] = torch.aten.int_repr %[[QUANT]] : !torch.vtensor<[1,1,7,7],!torch.quint8> -> !torch.vtensor<[1,1,7,7],ui8>
  // CHECK: return %[[INT]] : !torch.vtensor<[1,1,7,7],ui8>
  return %0 : !torch.vtensor<[1,1,7,7],ui8>
}

