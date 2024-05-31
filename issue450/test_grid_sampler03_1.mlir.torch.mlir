module {
  func.func @test_grid_sampler03(%arg0: !torch.vtensor<[5,10,10,4],f32>, %arg1: !torch.vtensor<[5,7,8,2],f32>) -> !torch.vtensor<[?,?,?,?],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %true = torch.constant.bool true
    %0 = torch.aten.grid_sampler %arg0, %arg1, %int1, %int0, %true : !torch.vtensor<[5,10,10,4],f32>, !torch.vtensor<[5,7,8,2],f32>, !torch.int, !torch.int, !torch.bool -> !torch.vtensor<[?,?,?,?],f32>
    return %0 : !torch.vtensor<[?,?,?,?],f32>
  }
}

