

// CHECK-LABEL: func.func @test_or2d
  func.func @test_or2d(%arg0: !torch.vtensor<[3,4],i1>, %arg1: !torch.vtensor<[3,4],i1>) -> !torch.vtensor<[3,4],i1> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 7 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.bitwise_or.Tensor %arg0, %arg1 : !torch.vtensor<[3,4],i1>, !torch.vtensor<[3,4],i1> -> !torch.vtensor<[3,4],i1>
    %0 = torch.operator "onnx.Or"(%arg0, %arg1) : (!torch.vtensor<[3,4],i1>, !torch.vtensor<[3,4],i1>) -> !torch.vtensor<[3,4],i1>
    return %0 : !torch.vtensor<[3,4],i1>
  }

// CHECK-LABEL: func.func @test_identity
  func.func @test_identity(%arg0: !torch.vtensor<[3,4], f32>) -> !torch.vtensor<[3,4], f32> attributes {torch.onnx_meta.ir_version = 14 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[NONE:.*]] = torch.constant.none
    // CHECK: %0 = torch.aten.clone %arg0, %[[NONE]] : !torch.vtensor<[3,4],f32>, !torch.none -> !torch.vtensor<[3,4],f32>
    %0 = torch.operator "onnx.Identity"(%arg0) : (!torch.vtensor<[3,4], f32>) -> !torch.vtensor<[3,4], f32>
    return %0 : !torch.vtensor<[3,4], f32>
  }

// CHECK-LABEL: func.func @test_mean_one_input
  func.func @test_mean_one_input(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.operator "onnx.Mean"(%arg0) : (!torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32>
    return %0 : !torch.vtensor<[3],f32>
  }

// CHECK-LABEL: func.func @test_mean_two_inputs
  func.func @test_mean_two_inputs(%arg0: !torch.vtensor<[3],f32>, %arg1: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[INT2:.*]] = torch.constant.int 2
    // CHECK: %[[INT1:.*]] = torch.constant.int 1
    // CHECK: torch.aten.add.Tensor %arg0, %arg1, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    // CHECK: torch.aten.div.Scalar %0, %int2 : !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    %0 = torch.operator "onnx.Mean"(%arg0, %arg1) : (!torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32>
    return %0 : !torch.vtensor<[3],f32>
  }

// CHECK-LABEL: func.func @test_isinf_negative
  func.func @test_isinf_negative(%arg0: !torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.neg %arg0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    // CHECK: torch.aten.relu %0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    // CHECK: torch.aten.isinf %1 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],i1>
    %0 = torch.operator "onnx.IsInf"(%arg0) {torch.onnx.detect_positive = 0 : si64} : (!torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1>
    return %0 : !torch.vtensor<[6],i1>
  }

// CHECK-LABEL: func.func @test_isinf_positive
  func.func @test_isinf_positive(%arg0: !torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.relu %arg0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    // CHECK: torch.aten.isinf %0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],i1>
    %0 = torch.operator "onnx.IsInf"(%arg0) {torch.onnx.detect_negative = 0 : si64} : (!torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1>
    return %0 : !torch.vtensor<[6],i1>
  }

// CHECK-LABEL: func.func @test_isnan
  func.func @test_isnan(%arg0: !torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.isnan %arg0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],i1>
    %0 = torch.operator "onnx.IsNaN"(%arg0) : (!torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1>
    return %0 : !torch.vtensor<[6],i1>
  }

// CHECK-LABEL: func.func @test_prelu_example
  func.func @test_prelu_example(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 16 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.prelu %arg0, %arg1 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %0 = torch.operator "onnx.PRelu"(%arg0, %arg1) : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }

// CHECK-LABEL: func.func @test_prelu_broadcast
  func.func @test_prelu_broadcast(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 16 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: torch.aten.prelu %arg0, %arg1 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[5],f32> -> !torch.vtensor<[3,4,5],f32>
    %0 = torch.operator "onnx.PRelu"(%arg0, %arg1) : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[5],f32>) -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }

