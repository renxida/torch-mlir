

// CHECK-LABEL: @test_cumsum_1d_exclusive
func.func @test_cumsum_1d_exclusive(%arg0: !torch.vtensor<[5],f64>, %arg1: !torch.vtensor<[],si32>) -> !torch.vtensor<[5],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[RANK:.*]] = torch.constant.int 1
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[AXIS:.*]] = torch.aten.item %arg1 : !torch.vtensor<[],si32> -> !torch.int
  // CHECK: %[[BOOL:.*]] = torch.aten.lt.int %[[AXIS]], %[[C0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[INT:.*]] = torch.aten.Int.bool %[[BOOL]] : !torch.bool -> !torch.int
  // CHECK: %[[OTHER:.*]] = torch.aten.mul.int %[[INT]], %[[RANK]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[ADD:.*]] = torch.aten.add.int %[[AXIS]], %[[OTHER]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: %[[CUMSUM:.*]] = torch.aten.cumsum %arg0, %[[ADD]], %[[NONE]] : !torch.vtensor<[5],f64>, !torch.int, !torch.none -> !torch.vtensor<[5],f64>
  // CHECK: torch.aten.sub.Tensor %[[CUMSUM]], %arg0, %[[C1]] : !torch.vtensor<[5],f64>, !torch.vtensor<[5],f64>, !torch.int -> !torch.vtensor<[5],f64>
  %0 = torch.operator "onnx.CumSum"(%arg0, %arg1) {torch.onnx.exclusive = 1 : si64} : (!torch.vtensor<[5],f64>, !torch.vtensor<[],si32>) -> !torch.vtensor<[5],f64>
  return %0 : !torch.vtensor<[5],f64>
}

