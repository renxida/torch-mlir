

// CHECK-LABEL: @test_concat_1d_axis_negative_1
func.func @test_concat_1d_axis_negative_1(%arg0: !torch.vtensor<[2],f32>, %arg1: !torch.vtensor<[2],f32>) -> !torch.vtensor<[4],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[TENSORS_LIST:.*]] = torch.prim.ListConstruct %arg0, %arg1 : (!torch.vtensor<[2],f32>, !torch.vtensor<[2],f32>) -> !torch.list<vtensor>
  // CHECK: %[[DIM:.*]] = torch.constant.int -1
  // CHECK: torch.aten.cat %[[TENSORS_LIST]], %[[DIM]] : !torch.list<vtensor>, !torch.int -> !torch.vtensor<[4],f32>
  %0 = torch.operator "onnx.Concat"(%arg0, %arg1) {torch.onnx.axis = -1 : si64} : (!torch.vtensor<[2],f32>, !torch.vtensor<[2],f32>) -> !torch.vtensor<[4],f32>
  return %0 : !torch.vtensor<[4],f32>
}

