

// CHECK-LABEL: func.func @test_split_2d_uneven_split_opset18(
// CHECK-SAME: %[[INPUT_TENSOR:.*]]: !torch.vtensor<[2,8],f32>) -> (!torch.vtensor<[2,3],f32>, !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,2],f32>) attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
// CHECK-DAG: %[[DIM:.+]] = torch.constant.int 1
// CHECK-DAG: %[[SPLITS:.+]] = torch.constant.int 3
// CHECK-DAG: %[[ONE:.+]] = torch.constant.int 1
// CHECK-DAG: %[[ZERO:.+]] = torch.constant.int 0
// CHECK-DAG: %[[SZ1:.+]] = torch.aten.size.int %arg0, %[[DIM]]
// CHECK-DAG: %[[ADD:.+]] = torch.aten.add.int %[[SZ1]], %[[SPLITS]]
// CHECK-DAG: %[[SUB:.+]] = torch.aten.sub.int %[[ADD]], %[[ONE]]
// CHECK-DAG: %[[SLICESZ:.+]] = torch.aten.floordiv.int %[[SUB]], %[[SPLITS]]
// CHECK-DAG: %[[START1:.+]] = torch.aten.add.int %[[ZERO]], %[[SLICESZ]] : !torch.int, !torch.int -> !torch.int
// CHECK-DAG: %[[SLICE0:.+]] = torch.aten.slice.Tensor %arg0, %[[DIM]], %[[ZERO]], %[[START1]], %[[ONE]] : !torch.vtensor<[2,8],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,3],f32>
// CHECK-DAG: %[[START2:.+]] = torch.aten.add.int %[[START1]], %[[SLICESZ]] : !torch.int, !torch.int -> !torch.int
// CHECK-DAG: %[[SLICE1:.+]] = torch.aten.slice.Tensor %arg0, %[[DIM]], %[[START1]], %[[START2]], %[[ONE]] : !torch.vtensor<[2,8],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,3],f32>
// CHECK-DAG: %[[SLICE2:.+]] = torch.aten.slice.Tensor %arg0, %[[DIM]], %[[START2]], %[[SZ1]], %[[ONE]] : !torch.vtensor<[2,8],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,2],f32>
// CHECK: return %[[SLICE0]], %[[SLICE1]], %[[SLICE2]]
func.func @test_split_2d_uneven_split_opset18(%arg0: !torch.vtensor<[2,8],f32>) -> (!torch.vtensor<[2,3],f32>, !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,2],f32>) attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  %0:3 = torch.operator "onnx.Split"(%arg0) {torch.onnx.axis = 1 : si64, torch.onnx.num_outputs = 3 : si64} : (!torch.vtensor<[2,8],f32>) -> (!torch.vtensor<[2,3],f32>, !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,2],f32>)
  return %0#0, %0#1, %0#2 : !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,2],f32>
}

