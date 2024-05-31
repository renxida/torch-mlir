

// CHECK-LABEL : func.func @test_top_k
func.func @test_top_k(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> (!torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>) attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64} {
  // CHECK: %[[AXIS:.*]] = torch.constant.int 1
  // CHECK: %[[LARGEST:.*]] = torch.constant.bool true
  // CHECK: %[[SORTED:.*]] = torch.constant.bool true
  // CHECK: %[[K:.*]] = torch.aten.item %arg1 : !torch.vtensor<[1],si64> -> !torch.int
  // CHECK: torch.aten.topk %arg0, %[[K]], %[[AXIS]], %[[LARGEST]], %[[SORTED]] : !torch.vtensor<[3,4],f32>, !torch.int, !torch.int, !torch.bool, !torch.bool -> !torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>
  %0:2 = torch.operator "onnx.TopK"(%arg0, %arg1) {torch.onnx.axis = 1 : si64} : (!torch.vtensor<[3,4],f32>, !torch.vtensor<[1],si64>) -> (!torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>)
  return %0#0, %0#1 : !torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>
}

