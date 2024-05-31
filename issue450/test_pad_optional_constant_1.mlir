

// CHECK-LABEL: @test_pad_optional_constant
// CHECK-SAME:    %[[ARG0:.*]]: !torch.vtensor<[3,4],f32>
// CHECK-SAME:    %[[ARG1:.*]]: !torch.vtensor<[4],si64>
// CHECK: %[[VAL:.+]] = torch.constant.float 0
// CHECK: %[[CONST_STR:.*]] = torch.constant.str "constant"
// CHECK: torch.aten.pad %[[ARG0]], %{{.*}}, %[[CONST_STR]], %[[VAL]] : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.str, !torch.float -> !torch.vtensor<[5,4],f32>

func.func @test_pad_optional_constant(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[4], si64>) -> !torch.vtensor<[5,4],f32> attributes {torch.onnx_meta.opset_version = 19 : si64} {
  %0 = torch.operator "onnx.Pad"(%arg0, %arg1) {torch.onnx.mode = "constant"} : (!torch.vtensor<[3,4],f32>, !torch.vtensor<[4], si64>) -> !torch.vtensor<[5,4],f32>
  return %0 : !torch.vtensor<[5,4],f32>
}

