module {
  func.func @test_gemm_defaultA(%arg0: !torch.vtensor<[3,5],f32>, %arg1: !torch.vtensor<[5,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %0 = torch.aten.mm %arg0, %arg1 : !torch.vtensor<[3,5],f32>, !torch.vtensor<[5,4],f32> -> !torch.vtensor<[3,4],f32>
    return %0 : !torch.vtensor<[3,4],f32>
  }
}

