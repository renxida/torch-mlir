

// CHECK-LABEL: func.func @test_reduce_sum_square_empty_set_non_reduced_axis_zero
func.func @test_reduce_sum_square_empty_set_non_reduced_axis_zero(%arg0: !torch.vtensor<[2,0,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,0,1],f32> attributes {torch.onnx_meta.ir_version = 8: si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[MULT:.+]] = torch.aten.mul.Tensor %arg0, %arg0 : !torch.vtensor<[2,0,4],f32>, !torch.vtensor<[2,0,4],f32> -> !torch.vtensor<[2,0,4],f32>
  // CHECK: %[[INT2:.+]] = torch.constant.int 2
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct %[[INT2]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[TRUE:.+]] = torch.constant.bool true
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: %[[SUM:.+]] = torch.aten.sum.dim_IntList %[[MULT]], %[[DIMS]], %[[TRUE]], %[[NONE]] : !torch.vtensor<[2,0,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[2,0,1],f32>
  // CHECK: return %[[SUM]] : !torch.vtensor<[2,0,1],f32>
  %0 = torch.operator "onnx.ReduceSumSquare"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[2,0,4],f32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,0,1],f32>
  return %0 : !torch.vtensor<[2,0,1],f32>
}

