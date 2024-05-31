

// CHECK-LABEL: @test_dequantizelinear_i32
func.func @test_dequantizelinear_i32(%arg0: !torch.vtensor<[6],si32>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],si32>) -> !torch.vtensor<[6],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64} {
  %0 = torch.operator "onnx.DequantizeLinear"(%arg0, %arg1, %arg2) : (!torch.vtensor<[6],si32>, !torch.vtensor<[],f32>, !torch.vtensor<[],si32>) -> !torch.vtensor<[6],f32>
  // CHECK: %[[SCALE:.+]] = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[ZP:.+]] = torch.aten.item %arg2 : !torch.vtensor<[],si32> -> !torch.int
  // CHECK: %[[MAKE:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg0, %[[SCALE]], %[[ZP]]
  // CHECK: %[[DEQ:.+]] = torch.aten.dequantize.self %[[MAKE]]
  // CHECK: return %[[DEQ]]
  return %0 : !torch.vtensor<[6],f32>
}

