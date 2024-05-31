

// CHECK-LABEL: @test_reduce_mean_one_axes_dropdims_example
func.func @test_reduce_mean_one_axes_dropdims_example(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
  // CHECK:  %[[TENSOR:.+]] = torch.vtensor.literal(dense<1> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
  // CHECK:  %[[DIM:.+]] = torch.constant.int 0
  // CHECK:  %[[A0:.+]] = torch.constant.int 0
  // CHECK:  %[[SEL0:.+]] = torch.aten.select.int %[[TENSOR]], %[[DIM]], %[[A0]]
  // CHECK:  %[[ITEM0:.+]] = torch.aten.item %[[SEL0]]
  // CHECK:  %[[LIST:.+]] = torch.prim.ListConstruct %[[ITEM0]]
  // CHECK:  %[[FALSE:.+]] = torch.constant.bool false
  // CHECK:  %[[NONE:.+]] = torch.constant.none
  // CHECK:  %[[SUM:.+]] = torch.aten.mean.dim %arg0, %[[LIST]], %[[FALSE]], %[[NONE]]
  // CHECK:  return %[[SUM]]
  %cst = torch.vtensor.literal(dense<1> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
  %0 = torch.operator "onnx.ReduceMean"(%arg0, %cst) {torch.onnx.keepdims = 0 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32>
  return %0 : !torch.vtensor<[3,2],f32>
}
