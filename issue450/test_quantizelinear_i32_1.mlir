

// CHECK-LABEL: @test_quantizelinear_i32
func.func @test_quantizelinear_i32(%arg0: !torch.vtensor<[6],f32>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],si32>) -> !torch.vtensor<[6],si32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64} {
  %0 = torch.operator "onnx.QuantizeLinear"(%arg0, %arg1, %arg2) : (!torch.vtensor<[6],f32>, !torch.vtensor<[],f32>, !torch.vtensor<[],si32>) -> !torch.vtensor<[6],si32>
  // CHECK: %[[C14:.+]] = torch.constant.int 14
  // CHECK: %[[SCALE:.+]] = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[ZP:.+]] = torch.aten.item %arg2 : !torch.vtensor<[],si32> -> !torch.int
  // CHECK: %[[QUANT:.+]] = torch.aten.quantize_per_tensor %arg0, %[[SCALE]], %[[ZP]], %[[C14]]
  // CHECK: %[[REPR:.+]] = torch.aten.int_repr %[[QUANT]]
  // CHECK: return %[[REPR]]
  return %0 : !torch.vtensor<[6],si32>
}

