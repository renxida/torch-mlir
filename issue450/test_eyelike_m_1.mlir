

// CHECK-LABEL: func.func @test_eyelike_m
func.func @test_eyelike_m(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4], f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[DIM0:.*]] = torch.aten.size.int %arg0, %[[INT0]] : !torch.vtensor<[3,4],f32>, !torch.int -> !torch.int
  // CHECK: %[[DIM1:.*]] = torch.aten.size.int %arg0, %[[INT1]] : !torch.vtensor<[3,4],f32>, !torch.int -> !torch.int
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[DTYPE:.*]] = torch.constant.int 6
  // CHECK: torch.aten.eye.m %[[DIM0]], %[[DIM1]], %[[DTYPE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,4],f32>
  %0 = torch.operator "onnx.EyeLike"(%arg0) : (!torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32>
  return %0 : !torch.vtensor<[3,4],f32>
}

