

// CHECK-LABEL: func.func @test_eyelike_dynamic
func.func @test_eyelike_dynamic(%arg0: !torch.vtensor<[3,?],f32>) -> !torch.vtensor<[3,?], f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.*]] = torch.constant.int 0
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[DIM0:.*]] = torch.aten.size.int %arg0, %[[INT0]] : !torch.vtensor<[3,?],f32>, !torch.int -> !torch.int
  // CHECK: %[[DIM1:.*]] = torch.aten.size.int %arg0, %[[INT1]] : !torch.vtensor<[3,?],f32>, !torch.int -> !torch.int
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[DTYPE:.*]] = torch.constant.int 6
  // CHECK: %[[DIAG:.*]] = torch.constant.int 1
  // CHECK: %[[NEW_DIM:.*]] = torch.aten.sub.int %[[DIM0]], %[[DIAG]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[EYE:.*]] = torch.aten.eye.m %[[NEW_DIM]], %[[DIM1]], %[[DTYPE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2,?],f32>
  // CHECK: %[[SHAPE:.*]] = torch.prim.ListConstruct %[[DIM0]], %[[DIM1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[ZEROS:.*]] = torch.aten.zeros %[[SHAPE]], %[[DTYPE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,?],f32>
  // CHECK: torch.aten.slice_scatter %[[ZEROS]], %[[EYE]], %[[INT0]], %[[DIAG]], %[[DIM0]], %[[INT1]] : !torch.vtensor<[3,?],f32>, !torch.vtensor<[2,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,?],f32>
  %0 = torch.operator "onnx.EyeLike"(%arg0) {torch.onnx.k = -1 : si64} : (!torch.vtensor<[3,?],f32>) -> !torch.vtensor<[3,?],f32>
  return %0 : !torch.vtensor<[3,?],f32>
}

