

// CHECK-LABEL: func.func @test_size
func.func @test_size(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[],si32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 9 : si64} {
  // CHECK-DAG  %[[INT0:.+]] = torch.constant.int 0
  // CHECK-DAG  %[[INT1:.+]] = torch.constant.int 1
  // CHECK-DAG  %[[INT2:.+]] = torch.constant.int 2
  // CHECK-DAG  %[[D0:.+]] = torch.aten.size.int %arg0, %[[INT0]]
  // CHECK-DAG  %[[D1:.+]] = torch.aten.size.int %arg0, %[[INT1]]
  // CHECK-DAG  %[[D2:.+]] = torch.aten.size.int %arg0, %[[INT2]]
  // CHECK-DAG  %[[FALSE:.+]] = torch.constant.bool false
  // CHECK-DAG  %[[NONE:.+]] = torch.constant.none
  // CHECK-DAG  %[[MUL0:.+]] = torch.aten.mul.int %[[D0]], %[[D1]]
  // CHECK-DAG  %[[MUL1:.+]] = torch.aten.mul.int %[[MUL0]], %[[D3]]
  // CHECK-DAG  %[[TENSOR:.+]] = torch.aten.tensor.int %[[MUL1]], %[[NONE]], %[[NONE]], %[[FALSE]]
  // CHECK      return %[[TENSOR]]
  %0 = torch.operator "onnx.Size"(%arg0) : (!torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[],si32>
  return %0 : !torch.vtensor<[],si32>
}

