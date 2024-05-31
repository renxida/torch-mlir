module {
  func.func @test_compress(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,3,2],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %0 = torch.aten.nonzero %arg1 : !torch.vtensor<[3],si64> -> !torch.vtensor<[2],si64>
    %1 = torch.aten.index_select %arg0, %int2, %0 : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.vtensor<[2],si64> -> !torch.vtensor<[2,3,2],f32>
    return %1 : !torch.vtensor<[2,3,2],f32>
  }
}

