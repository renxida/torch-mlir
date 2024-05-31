

// CHECK-LABEL: @test_batchnorm_example
func.func @test_batchnorm_example(%arg0: !torch.vtensor<[2,3,4,5],f32>, %arg1: !torch.vtensor<[3],f32>, %arg2: !torch.vtensor<[3],f32>, %arg3: !torch.vtensor<[3],f32>, %arg4: !torch.vtensor<[3],f32>) -> !torch.vtensor<[2,3,4,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[MOMENTUM:.*]] = torch.constant.float 0.89999997615814208
  // CHECK: %[[EPS:.*]] = torch.constant.float 9.9999997473787516E-6
  // CHECK: torch.aten.batch_norm %arg0, %arg1, %arg2, %arg3, %arg4, %[[FALSE]], %[[MOMENTUM]], %[[EPS]], %[[FALSE]] : !torch.vtensor<[2,3,4,5],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.bool, !torch.float, !torch.float, !torch.bool -> !torch.vtensor<[2,3,4,5],f32>
  %0 = torch.operator "onnx.BatchNormalization"(%arg0, %arg1, %arg2, %arg3, %arg4) : (!torch.vtensor<[2,3,4,5],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>) -> !torch.vtensor<[2,3,4,5],f32>
  return %0 : !torch.vtensor<[2,3,4,5],f32>
}

