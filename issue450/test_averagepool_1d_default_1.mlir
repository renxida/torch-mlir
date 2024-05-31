

// CHECK-LABEL: @test_averagepool_1d_default
func.func @test_averagepool_1d_default(%arg0: !torch.vtensor<[1,3,32],f32>) -> !torch.vtensor<[1,3,31],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.avg_pool1d %arg0, %0, %2, %1, %false, %true : !torch.vtensor<[1,3,32],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.bool -> !torch.vtensor<[1,3,31],f32>
  %0 = torch.operator "onnx.AveragePool"(%arg0) {torch.onnx.kernel_shape = [2 : si64], torch.onnx.count_include_pad = 1 : si64} : (!torch.vtensor<[1,3,32],f32>) -> !torch.vtensor<[1,3,31],f32>
  return %0 : !torch.vtensor<[1,3,31],f32>
}

