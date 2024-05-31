

// CHECK-LABEL: func.func @test_unsqueeze_three_axes
func.func @test_unsqueeze_three_axes(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[3,4,1,5,1,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT2:.*]] = torch.constant.int 2
  // CHECK: %[[UNSQUEEZE:.*]] = torch.aten.unsqueeze %arg0, %[[INT2]] : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,4,1,5],f32>
  // CHECK: %[[INT4:.*]] = torch.constant.int 4
  // CHECK: %[[UNSQUEEZE_1:.*]] = torch.aten.unsqueeze %[[UNSQUEEZE]], %[[INT4]] : !torch.vtensor<[3,4,1,5],f32>, !torch.int -> !torch.vtensor<[3,4,1,5,1],f32>
  // CHECK: %[[INT5:.*]] = torch.constant.int 5
  // CHECK: torch.aten.unsqueeze %[[UNSQUEEZE_1]], %[[INT5]] : !torch.vtensor<[3,4,1,5,1],f32>, !torch.int -> !torch.vtensor<[3,4,1,5,1,1],f32>
  %0 = torch.operator "onnx.Unsqueeze"(%arg0, %arg1) : (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3],si64>) -> !torch.vtensor<[3,4,1,5,1,1],f32>
  return %0 : !torch.vtensor<[3,4,1,5,1,1],f32>
}

