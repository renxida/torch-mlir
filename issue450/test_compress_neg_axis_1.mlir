

// CHECK-LABEL: func.func @test_compress_neg_axis
func.func @test_compress_neg_axis(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[2,2,4], f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[CST:.*]] = torch.vtensor.literal(dense<[0, 1, 1]> : tensor<3xsi64>) : !torch.vtensor<[3],si64>
  // CHECK: %[[INDEX:.*]] = torch.aten.nonzero %[[CST]] : !torch.vtensor<[3],si64> -> !torch.vtensor<[2],si64>
  // CHECK: %[[DIM:.*]] = torch.constant.int 1
  // CHECK: %[[ATEN_INDEX_SELECT:.*]] = torch.aten.index_select %arg0, %[[DIM]], %[[INDEX]] : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.vtensor<[2],si64> -> !torch.vtensor<[2,2,4],f32>
  %cst = torch.vtensor.literal(dense<[0,1,1]> : tensor<3xsi64>) : !torch.vtensor<[3], si64>
  %0 = torch.operator "onnx.Compress"(%arg0, %cst) {torch.onnx.axis = -2 : si64} : (!torch.vtensor<[2,3,4],f32>, !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,2,4],f32>
  return %0 : !torch.vtensor<[2,2,4],f32>
}

