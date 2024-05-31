// RUN: torch-mlir-opt <%s --split-input-file -convert-torch-onnx-to-torch | FileCheck %s
// Generally, the test cases accumulated here come from running the importer
// over all included backend tests that involve simple ops with no model
// level constants. This is a pragmatic choice which lets us have a lot
// of tests in this file, whereas the others tend to be more bespoke.

// CHECK-LABEL: @test_quantizelinear_si8
func.func @test_quantizelinear_si8(%arg0: !torch.vtensor<[6],f32>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],si8>) -> !torch.vtensor<[6],si8> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64} {
  %0 = torch.operator "onnx.QuantizeLinear"(%arg0, %arg1, %arg2) : (!torch.vtensor<[6],f32>, !torch.vtensor<[],f32>, !torch.vtensor<[],si8>) -> !torch.vtensor<[6],si8>

  // CHECK: %[[C12:.+]] = torch.constant.int 12
  // CHECK: %[[SCALE:.+]] = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
  // CHECK: %[[ZP:.+]] = torch.aten.item %arg2 : !torch.vtensor<[],si8> -> !torch.int
  // CHECK: %[[QUANT:.+]] = torch.aten.quantize_per_tensor %arg0, %[[SCALE]], %[[ZP]], %[[C12]]
  // CHECK: %[[REPR:.+]] = torch.aten.int_repr %[[QUANT]]
  // CHECK: return %[[REPR]]
  return %0 : !torch.vtensor<[6],si8>
}

