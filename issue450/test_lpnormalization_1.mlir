

// CHECK-LABEL: @test_lpnormalization
func.func @test_lpnormalization(%arg0: !torch.vtensor<[3,4,5,6,7],f32>) -> !torch.vtensor<[3,4,1,6,7],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 22 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[CST2:.*]] = torch.constant.int 2
  // CHECK: %[[CST2_0:.*]] = torch.constant.int 2
  // CHECK: %[[TRUE:.*]] = torch.constant.bool true
  // CHECK: %[[DIMS:.*]] = torch.prim.ListConstruct %[[CST2]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[OUT:.*]] = torch.aten.norm.ScalarOpt_dim %arg0, %[[CST2_0]], %[[DIMS]], %[[TRUE]] : !torch.vtensor<[3,4,5,6,7],f32>, !torch.int, !torch.list<int>, !torch.bool -> !torch.vtensor<[3,4,1,6,7],f32>
  // CHECK: return %[[OUT]] : !torch.vtensor<[3,4,1,6,7],f32>
  %0 = torch.operator "onnx.LpNormalization"(%arg0) {torch.onnx.axis = 2 : si64, torch.onnx.p = 2 : si64} : (!torch.vtensor<[3,4,5,6,7],f32>) -> !torch.vtensor<[3,4,1,6,7],f32>
  return %0 : !torch.vtensor<[3,4,1,6,7],f32>
}
