

// CHECK-LABEL: @test_dropout_default_mask
func.func @test_dropout_default_mask(%arg0: !torch.vtensor<[3,4,5],f32>) -> (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>) attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.dropout %arg0, %float5.000000e-01, %false : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.bool -> !torch.vtensor<[3,4,5],f32>
  // CHECK: torch.aten.ones_like %arg0, %int11, %none, %none, %none, %none : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,4,5],i1>
  %0:2 = torch.operator "onnx.Dropout"(%arg0) {torch.onnx.seed = 0 : si64} : (!torch.vtensor<[3,4,5],f32>) -> (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>)
  return %0#0, %0#1 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>
}

