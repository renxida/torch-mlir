

// CHECK-LABEL: @test_hardsigmoid_default
func.func @test_hardsigmoid_default(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[ALPHA_FLOAT:.*]] = torch.constant.float 0.20000000298023224
    // CHECK: %[[BETA_FLOAT:.*]] = torch.constant.float 5.000000e-01
    // CHECK: %[[ALPHA_MULTI_X_PLUS_BETA:.*]] = torch.aten.add.Scalar %arg0, %[[BETA_FLOAT:.*]], %[[ALPHA_FLOAT:.*]] : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.float -> !torch.vtensor<[3,4,5],f32>
    // CHECK: %[[INT_1:.*]] = torch.constant.int 1
    // CHECK: %[[TENSOR_DIMENSION_LIST_FOR_ONE:.*]] = torch.prim.ListConstruct  : () -> !torch.list<int>
    // CHECK: %[[NONE_FOR_ONE:.*]] = torch.constant.none
    // CHECK: %[[INT_TYPE_FOR_TENSOR_ONE:.*]] = torch.constant.int 6
    // CHECK: %[[ONE_TENSOR:.*]] = torch.aten.full %[[TENSOR_DIMENSION_LIST_FOR_ONE:.*]], %[[INT_1:.*]], %[[INT_TYPE_FOR_TENSOR_ONE:.*]], %[[NONE_FOR_ONE:.*]], %[[NONE_1:.*]], %[[NONE_1:.*]] : !torch.list<int>, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
    // CHECK: %[[MIN_EXPRESSION:.*]] = torch.aten.minimum %[[ONE_TENSOR:.*]], %[[ALPHA_MULTI_X_PLUS_BETA:.*]] : !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    // CHECK: %[[INT_0:.*]] = torch.constant.int 0
    // CHECK: %[[TENSOR_DIMENSION_LIST_FOR_ZERO:.*]] = torch.prim.ListConstruct  : () -> !torch.list<int>
    // CHECK: %[[NONE_FOR_ZERO:.*]] = torch.constant.none
    // CHECK: %[[INT_TYPE_FOR_TENSOR_ZERO:.*]] = torch.constant.int 6
    // CHECK: %[[ZERO_TENSOR:.*]] = torch.aten.full %[[TENSOR_DIMENSION_LIST_FOR_ZERO:.*]], %[[INT_0:.*]], %[[INT_TYPE_FOR_TENSOR_ZERO:.*]], %[[NONE_FOR_ZERO:.*]], %none_0, %none_0 : !torch.list<int>, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
    // CHECK: torch.aten.maximum %[[ZERO_TENSOR:.*]], %[[MIN_EXPRESSION:.*]] : !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
  %0 = torch.operator "onnx.HardSigmoid"(%arg0) : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

