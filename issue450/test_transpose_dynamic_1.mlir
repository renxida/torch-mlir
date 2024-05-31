

// CHECK-LABEL: func.func @test_transpose_dynamic
func.func @test_transpose_dynamic(%arg0: !torch.vtensor<[?,32,5,128],f32>) -> !torch.vtensor<[?,5,32,128],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK-DAG:  %[[I1:.+]] = torch.constant.int 1
  // CHECK-DAG:  %[[I2:.+]] = torch.constant.int 2
  // CHECK:  %[[TRANSPOSE:.+]] = torch.aten.transpose.int %arg0, %[[I1]], %[[I2]] : !torch.vtensor<[?,32,5,128],f32>, !torch.int, !torch.int -> !torch.vtensor<[?,5,32,128],f32>
  %0 = torch.operator "onnx.Transpose"(%arg0) {torch.onnx.perm = [0 : si64, 2 : si64, 1 : si64, 3 : si64]} : (!torch.vtensor<[?,32,5,128],f32>) -> !torch.vtensor<[?,5,32,128],f32>
  return %0 : !torch.vtensor<[?,5,32,128],f32>
}


