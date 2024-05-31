

// CHECK-LABEL: @test_reduce_mean_one_axesattr_dropdims_example
func.func @test_reduce_mean_one_axesattr_dropdims_example(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
  // CHECK: %[[INT1:.+]] = torch.constant.int 1
  // CHECK: %[[LIST:.+]] = torch.prim.ListConstruct %[[INT1]]
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: %[[MEAN:.+]] = torch.aten.mean.dim %arg0, %[[LIST]], %[[FALSE]], %[[NONE]]
  // CHECK: return %[[MEAN]]
  %0 = torch.operator "onnx.ReduceMean"(%arg0) {torch.onnx.keepdims = 0 : si64, torch.onnx.axes = [1 : si64]} : (!torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,2],f32>
  return %0 : !torch.vtensor<[3,2],f32>
}

