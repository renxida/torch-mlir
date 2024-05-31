

// CHECK-LABEL: func.func @test_blackmanwindow_symmetric
func.func @test_blackmanwindow_symmetric(%arg0: !torch.vtensor<[],si32>) -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK-DAG: %[[A0:.+]] = torch.constant.float 4.200000e-01
  // CHECK-DAG: %[[A1:.+]] = torch.constant.float -5.000000e-01
  // CHECK-DAG: %[[A2:.+]] = torch.constant.float 8.000000e-02
  // CHECK-DAG: %[[FLOAT0_0:.+]] = torch.constant.float 0.000000e+00
  // CHECK-DAG: %[[FLOAT1:.+]] = torch.constant.float 1.000000e+00
  // CHECK-DAG: %[[FLOAT2:.+]] = torch.constant.float 2.000000e+00
  // CHECK-DAG: %[[TWOPI:.+]] = torch.constant.float 6.2831853071795862
  // CHECK-DAG: %[[NONE:.+]] = torch.constant.none
  // CHECK-DAG: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK-DAG: %[[INT6:.+]] = torch.constant.int 6
  // CHECK-DAG: %[[CAST_0:.+]] = torch.aten.to.dtype %arg0, %[[INT6]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[],si32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[SYMMSIZE:.+]] = torch.aten.sub.Scalar %[[CAST_0]], %[[FLOAT1]], %[[FLOAT1]] : !torch.vtensor<[],f32>, !torch.float, !torch.float -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[PERIODIC:.+]] = torch.constant.float 0.000000e+00
  // CHECK-DAG: %[[SYMMETRIC:.+]] = torch.constant.float 1.000000e+00
  // CHECK-DAG: %[[PERIODICCOMP:.+]] = torch.aten.mul.Scalar %[[CAST_0]], %[[PERIODIC]] : !torch.vtensor<[],f32>, !torch.float -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[SYMMETRICCOMP:.+]] = torch.aten.mul.Scalar %[[SYMMSIZE]], %[[SYMMETRIC]] : !torch.vtensor<[],f32>, !torch.float -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[SIZEFP:.+]] = torch.aten.add.Tensor %[[SYMMETRICCOMP]], %[[PERIODICCOMP]], %[[FLOAT1]] : !torch.vtensor<[],f32>, !torch.vtensor<[],f32>, !torch.float -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[RANGELIM:.+]] = torch.aten.item %arg0 : !torch.vtensor<[],si32> -> !torch.int
  // CHECK-DAG: %[[ARANGE:.+]] = torch.aten.arange.start_step %[[FLOAT0_0]], %[[RANGELIM]], %[[FLOAT1]], %[[NONE]], %[[NONE]], %[[NONE]], %[[NONE]] : !torch.float, !torch.int, !torch.float, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[RANGETIMESTAU:.+]] = torch.aten.mul.Scalar %[[ARANGE]], %[[TWOPI]] : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[RANGEANGULAR:.+]] = torch.aten.div.Tensor %[[RANGETIMESTAU]], %[[SIZEFP]] : !torch.vtensor<[10],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[TWORANGEANGULAR:.+]] = torch.aten.mul.Scalar %[[RANGEANGULAR]], %[[FLOAT2]] : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[COSRANGEANGULAR:.+]] = torch.aten.cos %[[RANGEANGULAR]] : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[COSTWORANGEANGULAR:.+]] = torch.aten.cos %[[TWORANGEANGULAR]] : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[A1COMP:.+]] = torch.aten.mul.Scalar %[[COSRANGEANGULAR]], %[[A1]] : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[A2COMP:.+]] = torch.aten.mul.Scalar %[[COSTWORANGEANGULAR]], %[[A2]] : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[RES:.+]] = torch.aten.add.Scalar %[[A1COMP]], %[[A0]], %[[FLOAT1]] : !torch.vtensor<[10],f32>, !torch.float, !torch.float -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[RESULT:.+]] = torch.aten.add.Tensor %[[RES]], %[[A2COMP]], %[[FLOAT1]] : !torch.vtensor<[10],f32>, !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
  // CHECK-DAG: %[[INT6_1:.+]] = torch.constant.int 6
  // CHECK: %[[CAST:.+]] = torch.aten.to.dtype %[[RESULT]], %[[INT6_1]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[10],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[10],f32>
  // CHECK: return %[[CAST]] : !torch.vtensor<[10],f32>
  %0 = torch.operator "onnx.BlackmanWindow"(%arg0) {torch.onnx.periodic = 0 : si64} : (!torch.vtensor<[],si32>) -> !torch.vtensor<[10],f32>
  return %0 : !torch.vtensor<[10],f32>
}

