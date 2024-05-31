

// CHECK-LABEL: func.func @test_reshape_reduced_dims
func.func @test_reshape_reduced_dims(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[2],si64>) -> !torch.vtensor<[2,12],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT2:.+]] = torch.constant.int 2
  // CHECK: %[[INT12:.+]] = torch.constant.int 12
  // CHECK: %[[RESULT_SHAPE:.+]] = torch.prim.ListConstruct %[[INT2]], %[[INT12]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: torch.aten.reshape %arg0, %[[RESULT_SHAPE]] : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,12],f32>
  %0 = torch.operator "onnx.Reshape"(%arg0, %arg1) : (!torch.vtensor<[2,3,4],f32>, !torch.vtensor<[2],si64>) -> !torch.vtensor<[2,12],f32>
  return %0 : !torch.vtensor<[2,12],f32>
}

