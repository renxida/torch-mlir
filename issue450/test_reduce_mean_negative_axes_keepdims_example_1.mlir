

// CHECK-LABEL: @test_reduce_mean_negative_axes_keepdims_example
func.func @test_reduce_mean_negative_axes_keepdims_example(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[3,1,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK:  %[[TENSOR:.+]] = torch.vtensor.literal(dense<-2> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
  // CHECK:  %[[DIM:.+]] = torch.constant.int 0
  // CHECK:  %[[A0:.+]] = torch.constant.int 0
  // CHECK:  %[[SEL0:.+]] = torch.aten.select.int %[[TENSOR]], %[[DIM]], %[[A0]]
  // CHECK:  %[[ITEM0:.+]] = torch.aten.item %[[SEL0]]
  // CHECK:  %[[LIST:.+]] = torch.prim.ListConstruct %[[ITEM0]]
  // CHECK:  %[[TRUE:.+]] = torch.constant.bool true
  // CHECK:  %[[NONE:.+]] = torch.constant.none
  // CHECK:  %[[SUM:.+]] = torch.aten.mean.dim %arg0, %[[LIST]], %[[TRUE]], %[[NONE]]
  // CHECK:  return %[[SUM]]
  %cst = torch.vtensor.literal(dense<-2> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
  %0 = torch.operator "onnx.ReduceMean"(%arg0, %cst) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,2],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,2],f32>
  return %0 : !torch.vtensor<[3,1,2],f32>
}

