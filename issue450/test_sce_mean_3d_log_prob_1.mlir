

// CHECK-LABEL: func.func @test_sce_mean_3d_log_prob
func.func @test_sce_mean_3d_log_prob(%arg0: !torch.vtensor<[3,5,2],f32>, %arg1: !torch.vtensor<[3,2],si64>) -> (!torch.vtensor<[],f32>, !torch.vtensor<[3,5,2],f32>) attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: %[[IGNORE_INDEX:.+]] = torch.constant.int -100
  // CHECK: %[[REDUCTION:.+]] = torch.constant.int 1
  // CHECK: %[[LABEL_SMOOTHING:.+]] = torch.constant.float 0.000000e+00
  // CHECK: %[[LOSS:.+]] = torch.aten.cross_entropy_loss %arg0, %arg1, %[[NONE]], %[[REDUCTION]], %[[IGNORE_INDEX:.+]], %[[LABEL_SMOOTHING]] : !torch.vtensor<[3,5,2],f32>, !torch.vtensor<[3,2],si64>, !torch.none, !torch.int, !torch.int, !torch.float -> !torch.vtensor<[],f32>
  // CHECK: %[[DIM:.+]] = torch.constant.int 1
  // CHECK: %[[NONE_0:.+]] = torch.constant.none
  // CHECK: %[[PROB:.+]] = torch.aten.log_softmax.int %arg0, %[[DIM]], %[[NONE_0]] : !torch.vtensor<[3,5,2],f32>, !torch.int, !torch.none -> !torch.vtensor<[3,5,2],f32>
  // CHECK: return %[[LOSS]], %[[PROB]] : !torch.vtensor<[],f32>, !torch.vtensor<[3,5,2],f32>
  %0:2 = torch.operator "onnx.SoftmaxCrossEntropyLoss"(%arg0, %arg1) {torch.onnx.reduction = "mean"} : (!torch.vtensor<[3,5,2],f32>, !torch.vtensor<[3,2],si64>) -> (!torch.vtensor<[],f32>, !torch.vtensor<[3,5,2],f32>)
  return %0#0, %0#1 : !torch.vtensor<[],f32>, !torch.vtensor<[3,5,2],f32>
}

