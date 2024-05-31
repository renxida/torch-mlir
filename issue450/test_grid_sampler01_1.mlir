

// CHECK-LABEL: @test_grid_sampler01
// CHECK: %[[INT0:.*]] = torch.constant.int 0
// CHECK: %[[INT0_0:.*]] = torch.constant.int 0
// CHECK: %[[B0:.*]] = torch.constant.bool false
// CHECK: %[[A0:.*]] = torch.aten.grid_sampler %arg0, %arg1, %[[INT0]], %[[INT0_0]], %[[B0]] : !torch.vtensor<[5,10,10,4],f32>
func.func @test_grid_sampler01(%arg0: !torch.vtensor<[5,10,10,4],f32>, %arg1: !torch.vtensor<[5,7,8,2],f32>) -> !torch.vtensor<[?,?,?,?],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  %0 = torch.operator "onnx.GridSample" (%arg0, %arg1) {torch.onnx.align_corners = 0 : si64, torch.onnx.mode = "linear", torch.onnx.padding_mode = "zeros"} : (!torch.vtensor<[5,10,10,4],f32>, !torch.vtensor<[5,7,8,2],f32>) -> !torch.vtensor<[?,?,?,?],f32>
  return %0 : !torch.vtensor<[?,?,?,?],f32>
}

