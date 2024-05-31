

// CHECK-LABEL: func.func @test_reduce_mean_all_dims_keepdims_example
func.func @test_reduce_mean_all_dims_keepdims_example(%arg0: !torch.vtensor<[3,2,4],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[1,1,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[INT1:.+]] = torch.constant.int 1
  // CHECK: %[[INT2:.+]] = torch.constant.int 2
  // CHECK: %[[DIMS:.+]] = torch.prim.ListConstruct %[[INT0]], %[[INT1]], %[[INT2]] : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[KEEPDIM:.+]] = torch.constant.bool true
  // CHECK: %[[NONE:.+]] = torch.constant.none
  // CHECK: torch.aten.mean.dim %arg0, %[[DIMS]], %[[KEEPDIM]], %[[NONE]] : !torch.vtensor<[3,2,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f32>
  %0 = torch.operator "onnx.ReduceMean"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[3,2,4],f32>, !torch.vtensor<[3],si64>) -> !torch.vtensor<[1,1,1],f32>
  return %0 : !torch.vtensor<[1,1,1],f32>
}

