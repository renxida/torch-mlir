

// CHECK-LABEL: @test_dynamicquantizelinear
func.func @test_dynamicquantizelinear(%arg0: !torch.vtensor<[3,4,5],f32>) -> (!torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>) attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[MAX0:.*]] = torch.aten.max %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[MIN0:.*]] = torch.aten.min %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[CF0:.*]] = torch.constant.float 0.000000e+00
  // CHECK: %[[CI1:.*]] = torch.constant.int 1
  // CHECK: %[[LIST:.*]] = torch.prim.ListConstruct : () -> !torch.list<int>
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[CI6:.*]] = torch.constant.int 6
  // CHECK: %[[CF0_T:.*]] = torch.aten.full %[[LIST]], %[[CF0]], %[[CI6]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.list<int>, !torch.float, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
  // CHECK: %[[MAX:.*]] = torch.aten.maximum %[[MAX0]], %[[CF0_T]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[MIN:.*]] = torch.aten.minimum %[[MIN0]], %[[CF0_T]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[DIAM:.*]] = torch.aten.sub.Tensor %[[MAX]], %[[MIN]], %[[CI1]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32>, !torch.int -> !torch.vtensor<[],f32>
  // CHECK: %[[CQMAX:.*]] = torch.constant.float 2.550000e+02
  // CHECK: %[[LIST_1:.*]] = torch.prim.ListConstruct  : () -> !torch.list<int>
  // CHECK: %[[NONE_1:.*]] = torch.constant.none
  // CHECK: %[[CI6_1:.*]] = torch.constant.int 6
  // CHECK: %[[CQMAX_T:.*]] = torch.aten.full %[[LIST_1]], %[[CQMAX]], %[[CI6_1]], %[[NONE_1]], %[[NONE_1]], %[[NONE_1]] : !torch.list<int>, !torch.float, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
  // CHECK: %[[SCALE_T:.*]] = torch.aten.div.Tensor %[[DIAM]], %[[CQMAX_T]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[PZP_0:.*]] = torch.aten.div.Tensor %[[MIN0]], %[[SCALE_T]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[PZP_1:.*]] = torch.aten.sub.Tensor %[[CF0_T]], %[[PZP_0]], %[[CI1]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32>, !torch.int -> !torch.vtensor<[],f32>
  // CHECK: %[[PZP_2:.*]] = torch.aten.clamp %[[PZP_1]], %[[CF0]], %[[CQMAX]] : !torch.vtensor<[],f32>, !torch.float, !torch.float -> !torch.vtensor<[],f32>
  // CHECK: %[[PZP_3:.*]] = torch.aten.round %[[PZP_2]] : !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
  // CHECK: %[[CI13:.*]] = torch.constant.int 13
  // CHECK: %[[NONE_2:.*]] = torch.constant.none
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[ZP_T:.*]] = torch.aten.to.dtype %[[PZP_3]], %[[CI13]], %[[FALSE]], %[[FALSE]], %[[NONE_2]] : !torch.vtensor<[],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],ui8>
  // CHECK: %[[ZP:.*]] = torch.aten.item %[[ZP_T]] : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK: %[[SCALE:.*]] = torch.aten.item %[[SCALE_T]] : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[QUANT:.*]] = torch.aten.quantize_per_tensor %arg0, %[[SCALE]], %[[ZP]], %[[CI13]] : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[3,4,5],!torch.quint8>
  // CHECK: %[[INTQUANT:.*]] = torch.aten.int_repr %[[QUANT]] : !torch.vtensor<[3,4,5],!torch.quint8> -> !torch.vtensor<[3,4,5],ui8>
  %0:3 = torch.operator "onnx.DynamicQuantizeLinear"(%arg0) : (!torch.vtensor<[3,4,5],f32>) -> (!torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>)
  // CHECK: return %[[INTQUANT]], %[[SCALE_T]], %[[ZP_T]] : !torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>
  return %0#0, %0#1, %0#2 : !torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>
}

