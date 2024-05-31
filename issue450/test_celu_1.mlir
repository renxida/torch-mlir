

// CHECK-LABEL: func.func @test_celu
func.func @test_celu(%arg0: !torch.vtensor<[3,3,3,1],f32>) -> !torch.vtensor<[3,3,3,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK:  %[[ALPHA:.*]] = torch.constant.float 2.000000e+00
  // CHECK:  %0 = torch.aten.div.Scalar %arg0, %[[ALPHA]] : !torch.vtensor<[3,3,3,1],f32>, !torch.float -> !torch.vtensor<[3,3,3,1],f32>
  // CHECK:   %1 = torch.aten.exp %0 : !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
  // CHECK:    %int1 = torch.constant.int 1
  // CHECK:    %2 = torch.aten.sub.Scalar %1, %int1, %int1 : !torch.vtensor<[3,3,3,1],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,3,3,1],f32>
  // CHECK:    %3 = torch.aten.mul.Scalar %2, %[[ALPHA]] : !torch.vtensor<[3,3,3,1],f32>, !torch.float -> !torch.vtensor<[3,3,3,1],f32>
  // CHECK:    %int0 = torch.constant.int 0
  // CHECK:    %4 = torch.prim.ListConstruct  : () -> !torch.list<int>
  // CHECK:    %none = torch.constant.none
  // CHECK:    %int6 = torch.constant.int 6
  // CHECK:    %[[ZERO:.*]] = torch.aten.full %4, %int0, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[],f32>
  // CHECK:    %[[MIN:.*]] = torch.aten.minimum %[[ZERO]], %3 : !torch.vtensor<[],f32>, !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
  // CHECK:    %[[MAX:.*]] = torch.aten.maximum %[[ZERO]], %arg0 : !torch.vtensor<[],f32>, !torch.vtensor<[3,3,3,1],f32> -> !torch.vtensor<[3,3,3,1],f32>
  // CHECK:    %8 = torch.aten.add.Tensor %[[MAX]], %[[MIN]], %int1 : !torch.vtensor<[3,3,3,1],f32>, !torch.vtensor<[3,3,3,1],f32>, !torch.int -> !torch.vtensor<[3,3,3,1],f32>
  %0 = torch.operator "onnx.Celu"(%arg0) {torch.onnx.alpha = 2.000000e+00 : f32} : (!torch.vtensor<[3,3,3,1],f32>) -> !torch.vtensor<[3,3,3,1],f32>
  return %0 : !torch.vtensor<[3,3,3,1],f32>
}

