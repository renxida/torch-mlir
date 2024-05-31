module {
  func.func @test_gemm_alpha_beta(%arg0: !torch.vtensor<[3,5],f32>, %arg1: !torch.vtensor<[5,4],f32>, %arg2: !torch.vtensor<[1,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %float2.500000e-01 = torch.constant.float 2.500000e-01
    %float5.000000e-01 = torch.constant.float 5.000000e-01
    %0 = torch.aten.mm %arg0, %arg1 : !torch.vtensor<[3,5],f32>, !torch.vtensor<[5,4],f32> -> !torch.vtensor<[3,4],f32>
    %1 = torch.aten.mul.Scalar %0, %float5.000000e-01 : !torch.vtensor<[3,4],f32>, !torch.float -> !torch.vtensor<[3,4],f32>
    %2 = torch.aten.add.Tensor %1, %arg2, %float2.500000e-01 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[1,4],f32>, !torch.float -> !torch.vtensor<[3,4],f32>
    return %2 : !torch.vtensor<[3,4],f32>
  }
}

