module {
  func.func @test_gemm_transposeB(%arg0: !torch.vtensor<[3,5],f32>, %arg1: !torch.vtensor<[4,5],f32>, %arg2: !torch.vtensor<[1,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.aten.transpose.int %arg1, %int0, %int1 : !torch.vtensor<[4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[5,4],f32>
    %1 = torch.aten.mm %arg0, %0 : !torch.vtensor<[3,5],f32>, !torch.vtensor<[5,4],f32> -> !torch.vtensor<[3,4],f32>
    %2 = torch.aten.add.Tensor %1, %arg2, %int1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[1,4],f32>, !torch.int -> !torch.vtensor<[3,4],f32>
    return %2 : !torch.vtensor<[3,4],f32>
  }
}

