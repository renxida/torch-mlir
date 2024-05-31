

// CHECK-LABEL: func.func @test_range_int64_type
  func.func @test_range_int64_type(%arg0: !torch.vtensor<[],si64>, %arg1: !torch.vtensor<[],si64>, %arg2: !torch.vtensor<[],si64>) -> !torch.vtensor<[2],si64> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[NONE:.*]] torch.constant.none
    // CHECK: torch.aten.item %arg0 : !torch.vtensor<[],si64> -> !torch.int
    // CHECK: torch.aten.item %arg1 : !torch.vtensor<[],si64> -> !torch.int
    // CHECK: torch.aten.item %arg2 : !torch.vtensor<[],si64> -> !torch.int
    // CHECK: torch.aten.arange.start_step %0, %1, %2, %none, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2],si64>
    %0 = torch.operator "onnx.Range"(%arg0, %arg1, %arg2) : (!torch.vtensor<[],si64>, !torch.vtensor<[],si64>, !torch.vtensor<[],si64>) -> !torch.vtensor<[2],si64>
    return %0 : !torch.vtensor<[2],si64>
  }

