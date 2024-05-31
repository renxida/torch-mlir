

// CHECK-LABEL: func.func @test_gemm_defaultB
func.func @test_gemm_defaultB(%arg0: !torch.vtensor<[3,5],f32>, %arg1: !torch.vtensor<[5,4],f32>, %arg2: !torch.vtensor<[1,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK: %[[I1:.+]] = torch.constant.int 1
  // CHECK: %[[MM:.+]] = torch.aten.mm %arg0, %arg1 : !torch.vtensor<[3,5],f32>, !torch.vtensor<[5,4],f32> -> !torch.vtensor<[3,4],f32>
  // CHECK: torch.aten.add.Tensor %[[MM]], %arg2, %[[I1]] : !torch.vtensor<[3,4],f32>, !torch.vtensor<[1,4],f32>, !torch.int -> !torch.vtensor<[3,4],f32>
  %0 = torch.operator "onnx.Gemm"(%arg0, %arg1, %arg2) : (!torch.vtensor<[3,5],f32>, !torch.vtensor<[5,4],f32>, !torch.vtensor<[1,4],f32>) -> !torch.vtensor<[3,4],f32>
  return %0 : !torch.vtensor<[3,4],f32>
}

