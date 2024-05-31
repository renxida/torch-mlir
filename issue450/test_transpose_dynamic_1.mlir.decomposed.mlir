module {
  func.func @test_transpose_dynamic(%arg0: !torch.vtensor<[?,32,5,128],f32>) -> !torch.vtensor<[?,5,32,128],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %int1 = torch.constant.int 1
    %int2 = torch.constant.int 2
    %0 = torch.aten.transpose.int %arg0, %int1, %int2 : !torch.vtensor<[?,32,5,128],f32>, !torch.int, !torch.int -> !torch.vtensor<[?,5,32,128],f32>
    return %0 : !torch.vtensor<[?,5,32,128],f32>
  }
}

