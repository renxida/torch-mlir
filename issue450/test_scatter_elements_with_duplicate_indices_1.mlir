

// CHECK-LABEL: func.func @test_scatter_elements_with_duplicate_indices
func.func @test_scatter_elements_with_duplicate_indices(%arg0: !torch.vtensor<[1,5],f32>, %arg1: !torch.vtensor<[1,2],si64>, %arg2: !torch.vtensor<[1,2],f32>) -> !torch.vtensor<[1,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[STR:.*]] = torch.constant.str "add"
  // CHECK: torch.aten.scatter.reduce %arg0, %int1, %arg1, %arg2, %str : !torch.vtensor<[1,5],f32>, !torch.int, !torch.vtensor<[1,2],si64>, !torch.vtensor<[1,2],f32>, !torch.str -> !torch.vtensor<[1,5],f32>
  %0 = torch.operator "onnx.ScatterElements"(%arg0, %arg1, %arg2) {torch.onnx.axis = 1 : si64, torch.onnx.reduction = "add"} : (!torch.vtensor<[1,5],f32>, !torch.vtensor<[1,2],si64>, !torch.vtensor<[1,2],f32>) -> !torch.vtensor<[1,5],f32>
  return %0 : !torch.vtensor<[1,5],f32>
}

