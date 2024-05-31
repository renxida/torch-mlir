

// CHECK-LABEL: func.func @test_random_uniform
func.func @test_random_uniform() -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG:  %[[I6:.+]] = torch.constant.int 6
  // CHECK-DAG:  %[[I10:.+]] = torch.constant.int 10
  // CHECK: %[[SHAPE:.+]] = torch.prim.ListConstruct %[[I10]] : (!torch.int) -> !torch.list<int>
  // CHECK-DAG:  %[[NONE:.+]] = torch.constant.none
  // CHECK: %[[EMPTY_TENSOR:.+]] = torch.aten.empty.memory_format %[[SHAPE]], %[[I6]], %[[NONE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
  // CHECK-DAG:  %[[F1:.+]] = torch.constant.float 1.000000e+00
  // CHECK-DAG:  %[[F0:.+]] = torch.constant.float 0.000000e+00
  // CHECK: torch.aten.uniform %[[EMPTY_TENSOR]], %[[F0]], %[[F1]], %[[NONE]] : !torch.vtensor<[10],f32>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f32>
  %0 = torch.operator "onnx.RandomUniform"() {torch.onnx.dtype = 1 : si64, torch.onnx.high = 1.000000e+00 : f32, torch.onnx.low = 0.000000e+00 : f32, torch.onnx.shape = [10 : si64]} : () -> !torch.vtensor<[10],f32>
  return %0 : !torch.vtensor<[10],f32>
}

