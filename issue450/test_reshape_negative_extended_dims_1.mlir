

// CHECK-LABEL: func.func @test_reshape_negative_extended_dims
func.func @test_reshape_negative_extended_dims(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[1,2,3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT1:.+]] = torch.constant.int 1
  // CHECK: %[[INT2:.+]] = torch.constant.int 2
  // CHECK: %[[INT3:.+]] = torch.constant.int 3
  // CHECK: %[[INT4:.+]] = torch.constant.int 4
  // CHECK: %[[RESULT_SHAPE:.+]] = torch.prim.ListConstruct %[[INT1]], %[[INT2]], %[[INT3]], %[[INT4]] : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: torch.aten.reshape %arg0, %[[RESULT_SHAPE]] : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[1,2,3,4],f32>
  %0 = torch.operator "onnx.Reshape"(%arg0, %arg1) : (!torch.vtensor<[2,3,4],f32>, !torch.vtensor<[4],si64>) -> !torch.vtensor<[1,2,3,4],f32>
  return %0 : !torch.vtensor<[1,2,3,4],f32>
}

