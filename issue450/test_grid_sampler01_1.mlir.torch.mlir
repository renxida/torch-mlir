module {
  func.func @test_grid_sampler01(%arg0: !torch.vtensor<[5,10,10,4],f32>, %arg1: !torch.vtensor<[5,7,8,2],f32>) -> !torch.vtensor<[?,?,?,?],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %false = torch.constant.bool false
    %0 = torch.aten.grid_sampler %arg0, %arg1, %int0, %int0, %false : !torch.vtensor<[5,10,10,4],f32>, !torch.vtensor<[5,7,8,2],f32>, !torch.int, !torch.int, !torch.bool -> !torch.vtensor<[?,?,?,?],f32>
    return %0 : !torch.vtensor<[?,?,?,?],f32>
  }
}

