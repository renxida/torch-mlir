

// CHECK-LABEL: func.func @test_reduce_min_empty_set_int
func.func @test_reduce_min_empty_set_int(%arg0: !torch.vtensor<[2,0,4],si32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,1,4],si32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG: %[[INF:.+]] = torch.constant.int 2147483647
  // CHECK-DAG: %[[INT2:.+]] = torch.constant.int 2
  // CHECK-DAG: %[[INT1:.+]] = torch.constant.int 1
  // CHECK-DAG: %[[INT4:.+]] = torch.constant.int 4
  // CHECK-DAG: %[[NONE:.+]] = torch.constant.none
  // CHECK-DAG: %[[LIST:.+]] = torch.prim.ListConstruct %[[INT2]], %[[INT1]], %[[INT4]]
  // CHECK-DAG: %[[FULL:.+]] = torch.aten.full %[[LIST]], %[[INF]], %[[NONE]], %[[NONE]], %[[NONE]]
  // CHECK: return %[[FULL]]
  %0 = torch.operator "onnx.ReduceMin"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[2,0,4],si32>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[2,1,4],si32>
  return %0 : !torch.vtensor<[2,1,4],si32>
}

