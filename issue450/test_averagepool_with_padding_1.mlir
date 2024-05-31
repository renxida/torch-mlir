

// CHECK-LABEL: @test_averagepool_with_padding
// CHECK-SAME:    %[[ARG:.*]]: !torch.vtensor<[1,20,64,48],f32>
// CHECK: torch.aten.avg_pool2d %[[ARG]], {{.*}} : !torch.vtensor<[1,20,64,48],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[1,20,32,24],f32>

func.func @test_averagepool_with_padding(%arg0: !torch.vtensor<[1,20,64,48],f32>) -> !torch.vtensor<[1,20,32,24],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 19 : si64} {

  %0 = torch.operator "onnx.AveragePool"(%arg0) {torch.onnx.ceil_mode = 0 : si64, torch.onnx.kernel_shape = [2 : si64, 2 : si64], torch.onnx.pads = [0 : si64, 0 : si64, 0 : si64, 0 : si64], torch.onnx.strides = [2 : si64, 2 : si64]} : (!torch.vtensor<[1,20,64,48],f32>) -> !torch.vtensor<[1,20,32,24],f32>
  return %0 : !torch.vtensor<[1,20,32,24],f32>
}

