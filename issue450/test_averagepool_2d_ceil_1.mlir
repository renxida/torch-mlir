

// CHECK-LABEL: @test_averagepool_2d_ceil
func.func @test_averagepool_2d_ceil(%arg0: !torch.vtensor<[1,1,4,4],f32>) -> !torch.vtensor<[1,1,2,2],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: torch.aten.avg_pool2d %arg0, %0, %2, %1, %true, %false, %none : !torch.vtensor<[1,1,4,4],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[1,1,2,2],f32>
  %0 = torch.operator "onnx.AveragePool"(%arg0) {torch.onnx.ceil_mode = 1 : si64, torch.onnx.kernel_shape = [3 : si64, 3 : si64], torch.onnx.strides = [2 : si64, 2 : si64]} : (!torch.vtensor<[1,1,4,4],f32>) -> !torch.vtensor<[1,1,2,2],f32>
  return %0 : !torch.vtensor<[1,1,2,2],f32>
}

