module {
  func.func @test_transpose_default(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[4,3,2],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %int0 = torch.constant.int 0
    %int2 = torch.constant.int 2
    %0 = torch.aten.transpose.int %arg0, %int0, %int2 : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.int -> !torch.vtensor<[4,3,2],f32>
    return %0 : !torch.vtensor<[4,3,2],f32>
  }
}

