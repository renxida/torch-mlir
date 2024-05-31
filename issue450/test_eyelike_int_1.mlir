

// CHECK-LABEL: func.func @test_eyelike_int
func.func @test_eyelike_int(%arg0: !torch.vtensor<[3,3],f32>) -> !torch.vtensor<[3,3], si64> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[DIM0:.*]] = torch.aten.size.int %arg0, %[[INT0]] : !torch.vtensor<[3,3],f32>, !torch.int -> !torch.int
  // CHECK: %[[DIM1:.*]] = torch.aten.size.int %arg0, %[[INT1]] : !torch.vtensor<[3,3],f32>, !torch.int -> !torch.int
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[DTYPE:.*]] = torch.constant.int 4
  // CHECK: torch.aten.eye.m %[[DIM0]], %[[DIM1]], %[[DTYPE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,3],si64>
  %0 = torch.operator "onnx.EyeLike"(%arg0) {torch.onnx.dtype = 7 : si64} : (!torch.vtensor<[3,3],f32>) -> !torch.vtensor<[3,3],si64>
  return %0 : !torch.vtensor<[3,3],si64>
}

