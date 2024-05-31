

// CHECK-LABEL: func.func @test_compress
func.func @test_compress(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[3], si64>) -> !torch.vtensor<[2,3,2], f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INDEX:.*]] = torch.aten.nonzero %arg1 : !torch.vtensor<[3],si64> -> !torch.vtensor<[2],si64>
  // CHECK: %[[DIM:.*]] = torch.constant.int 2
  // CHECK: torch.aten.index_select %arg0, %[[DIM]], %[[INDEX]] : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.vtensor<[2],si64> -> !torch.vtensor<[2,3,2],f32>
  %0 = torch.operator "onnx.Compress"(%arg0, %arg1) {torch.onnx.axis = 2 : si64} : (!torch.vtensor<[2,3,4],f32>, !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,3,2],f32>
  return %0 : !torch.vtensor<[2,3,2],f32>
}

