

// CHECK-LABEL: func.func @test_squeeze_two_axes
func.func @test_squeeze_two_axes(%arg0: !torch.vtensor<[3,1,4,5,1],f32>, %arg1: !torch.vtensor<[2],si64>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT1:.*]] = torch.constant.int 1
  // CHECK: %[[INT4:.*]] = torch.constant.int 4
  // CHECK: %[[SQUEEZE_DIMS:.*]] = torch.prim.ListConstruct %[[INT1]], %[[INT4]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: torch.prims.squeeze %arg0, %[[SQUEEZE_DIMS]] : !torch.vtensor<[3,1,4,5,1],f32>, !torch.list<int> -> !torch.vtensor<[3,4,5],f32>
  %0 = torch.operator "onnx.Squeeze"(%arg0, %arg1) : (!torch.vtensor<[3,1,4,5,1],f32>, !torch.vtensor<[2],si64>) -> !torch.vtensor<[3,4,5],f32>
  return %0 : !torch.vtensor<[3,4,5],f32>
}

