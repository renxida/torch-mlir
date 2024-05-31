

// CHECK-LABEL: func.func @test_einsum_batch_diagonal
func.func @test_einsum_batch_diagonal(%arg0: !torch.vtensor<[3,5,5],f64>) -> !torch.vtensor<[3,5],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[TENSORS:.*]] = torch.prim.ListConstruct %arg0 : (!torch.vtensor<[3,5,5],f64>) -> !torch.list<vtensor>
  // CHECK: %[[EQUATION:.*]] = torch.constant.str "...ii ->...i"
  // CHECK: %[[PATH:.*]] = torch.constant.none
  // CHECK: torch.aten.einsum %[[EQUATION]], %[[TENSORS]], %[[PATH]] : !torch.str, !torch.list<vtensor>, !torch.none -> !torch.vtensor<[3,5],f64>
  %0 = torch.operator "onnx.Einsum"(%arg0) {torch.onnx.equation = "...ii ->...i"} : (!torch.vtensor<[3,5,5],f64>) -> !torch.vtensor<[3,5],f64>
  return %0 : !torch.vtensor<[3,5],f64>
}

