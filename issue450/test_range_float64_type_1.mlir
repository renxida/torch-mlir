

// CHECK-LABEL: func.func @test_range_float64_type
 func.func @test_range_float64_type(%arg0: !torch.vtensor<[],f64>, %arg1: !torch.vtensor<[],f64>, %arg2: !torch.vtensor<[],f64>) -> !torch.vtensor<[2],f64> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[NONE:.*]] torch.constant.none
    // CHECK: torch.aten.item %arg0 : !torch.vtensor<[],f64> -> !torch.float
    // CHECK: torch.aten.item %arg1 : !torch.vtensor<[],f64> -> !torch.float
    // CHECK: torch.aten.item %arg2 : !torch.vtensor<[],f64> -> !torch.float
    // CHECK: torch.aten.arange.start_step %0, %1, %2, %none, %none, %none, %none : !torch.float, !torch.float, !torch.float, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2],f64>
    %0 = torch.operator "onnx.Range"(%arg0, %arg1, %arg2) : (!torch.vtensor<[],f64>, !torch.vtensor<[],f64>, !torch.vtensor<[],f64>) -> !torch.vtensor<[2],f64>
    return %0 : !torch.vtensor<[2],f64>
  }

