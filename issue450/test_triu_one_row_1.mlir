

// CHECK-LABEL: func.func @test_triu_one_row
func.func @test_triu_one_row(%arg0: !torch.vtensor<[3,1,5],si64>, %arg1: !torch.vtensor<[],si64>) -> !torch.vtensor<[3,1,5],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[DIAGONAL:.*]] = torch.aten.item %arg1 : !torch.vtensor<[],si64> -> !torch.int
  // CHECK: torch.aten.triu %arg0, %[[DIAGONAL]] : !torch.vtensor<[3,1,5],si64>, !torch.int -> !torch.vtensor<[3,1,5],si64>
  %0 = torch.operator "onnx.Trilu"(%arg0, %arg1) : (!torch.vtensor<[3,1,5],si64>, !torch.vtensor<[],si64>) -> !torch.vtensor<[3,1,5],si64>
  return %0 : !torch.vtensor<[3,1,5],si64>
}

