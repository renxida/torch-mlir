

// CHECK-LABEL: func.func @test_compress_default_axis
func.func @test_compress_default_axis(%arg0: !torch.vtensor<[2,3],f32>) -> !torch.vtensor<[3], f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[CST:.*]] = torch.vtensor.literal(dense<[0, 1, 0, 1, 0, 1]> : tensor<6xsi64>) : !torch.vtensor<[6],si64>
  // CHECK: %[[INDEX:.*]] = torch.aten.nonzero %[[CST]] : !torch.vtensor<[6],si64> -> !torch.vtensor<[3],si64>
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[END_DIM:.*]] = torch.constant.int -1
  // CHECK: %[[ATEN_FLATTEN:.*]] = torch.aten.flatten.using_ints %arg0, %[[INT0]], %[[END_DIM]] : !torch.vtensor<[2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[6],f32>
  // CHECK: torch.aten.index_select %[[ATEN_FLATTEN]], %[[INT0]], %[[INDEX]] : !torch.vtensor<[6],f32>, !torch.int, !torch.vtensor<[3],si64> -> !torch.vtensor<[3],f32>
  %cst = torch.vtensor.literal(dense<[0,1,0,1,0,1]> : tensor<6xsi64>) : !torch.vtensor<[6], si64>
  %0 = torch.operator "onnx.Compress"(%arg0, %cst) : (!torch.vtensor<[2,3],f32>, !torch.vtensor<[6],si64>) -> !torch.vtensor<[3],f32>
  return %0 : !torch.vtensor<[3],f32>
}

