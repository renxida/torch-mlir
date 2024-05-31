

// CHECK-LABEL: @test_convinteger_without_padding
func.func @test_convinteger_without_padding(%arg0: !torch.vtensor<[1,1,3,3],ui8>, %arg1: !torch.vtensor<[1,1,2,2],ui8>, %arg2: !torch.vtensor<[],ui8>, %arg3: !torch.vtensor<[1],ui8>) -> !torch.vtensor<[1,1,2,2],si32> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[SCALE:.*]] = torch.constant.float 1.000000e+00
  // CHECK: %[[INPUT_ZP:.*]] = torch.aten.item %arg2 : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK: %[[WEIGHT_ZP:.*]] = torch.aten.item %arg3 : !torch.vtensor<[1],ui8> -> !torch.int
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[C0_0:.*]] = torch.constant.int 0
  // CHECK: %[[PADDING:.*]] = torch.prim.ListConstruct %[[C0]], %[[C0_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[C1_0:.*]] = torch.constant.int 1
  // CHECK: %[[C1_1:.*]] = torch.constant.int 1
  // CHECK: %[[DILATIONS:.*]] = torch.prim.ListConstruct %[[C1_0]], %[[C1_1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[C1_2:.*]] = torch.constant.int 1
  // CHECK: %[[C1_3:.*]] = torch.constant.int 1
  // CHECK: %[[STRIDE:.*]] = torch.prim.ListConstruct %[[C1_2]], %[[C1_3]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[C0_1:.*]] = torch.constant.int 0
  // CHECK: %[[C0_2:.*]] = torch.constant.int 0
  // CHECK: %[[OUTPUT_PADDING:.*]] = torch.prim.ListConstruct %[[C0_1]], %[[C0_2]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[TRANSPOSED:.*]] = torch.constant.bool false
  // CHECK: %[[BIAS:.*]] = torch.constant.none
  // CHECK: %[[GROUPS:.*]] = torch.constant.int 1
  // CHECK: %[[INPUT:.*]] = torch.aten._make_per_tensor_quantized_tensor %arg0, %[[SCALE]], %[[INPUT_ZP]] : !torch.vtensor<[1,1,3,3],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,3,3],!torch.quint8>
  // CHECK: %[[WEIGHT:.*]] = torch.aten._make_per_tensor_quantized_tensor %arg1, %[[SCALE]], %[[WEIGHT_ZP]] : !torch.vtensor<[1,1,2,2],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,2,2],!torch.quint8>
  // CHECK: torch.aten.convolution %[[INPUT]], %[[WEIGHT]], %[[BIAS]], %[[STRIDE]], %[[PADDING]], %[[DILATIONS]], %[[TRANSPOSED]], %[[OUTPUT_PADDING]], %[[GROUPS]] : !torch.vtensor<[1,1,3,3],!torch.quint8>, !torch.vtensor<[1,1,2,2],!torch.quint8>, !torch.none, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[1,1,2,2],si32>
  %none = torch.constant.none
  %0 = torch.operator "onnx.ConvInteger"(%arg0, %arg1, %arg2, %arg3) : (!torch.vtensor<[1,1,3,3],ui8>, !torch.vtensor<[1,1,2,2],ui8>, !torch.vtensor<[],ui8>, !torch.vtensor<[1],ui8>) -> !torch.vtensor<[1,1,2,2],si32>
  return %0 : !torch.vtensor<[1,1,2,2],si32>
}

