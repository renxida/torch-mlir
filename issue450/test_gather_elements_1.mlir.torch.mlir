module {
  func.func @test_gather_elements(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[3,4,5],si64>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
    %int0 = torch.constant.int 0
    %false = torch.constant.bool false
    %0 = torch.aten.gather %arg0, %int0, %arg1, %false : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.vtensor<[3,4,5],si64>, !torch.bool -> !torch.vtensor<[3,4,5],f32>
    return %0 : !torch.vtensor<[3,4,5],f32>
  }
}

