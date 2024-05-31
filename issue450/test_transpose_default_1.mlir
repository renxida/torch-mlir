

// CHECK-LABEL: func.func @test_transpose_default
func.func @test_transpose_default(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[4,3,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK-DAG: %[[I0:.+]] = torch.constant.int 0
  // CHECK-DAG: %[[I2:.+]] = torch.constant.int 2
  // CHECK: %[[TRANSPOSE:.+]] = torch.aten.transpose.int %arg0, %[[I0]], %[[I2]] : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.int -> !torch.vtensor<[4,3,2],f32>
  %0 = torch.operator "onnx.Transpose"(%arg0) : (!torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[4,3,2],f32>

  // CHECK: return %[[TRANSPOSE]]
  return %0 : !torch.vtensor<[4,3,2],f32>
}

