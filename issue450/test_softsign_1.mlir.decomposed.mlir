module {
  func.func @test_softsign(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 10 : si64, torch.onnx_meta.opset_version = 22 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.aten.abs %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %1 = torch.aten.add.Scalar %0, %int1, %int1 : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,4,5],f32>
    %2 = torch.aten.div.Tensor %arg0, %1 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    return %2 : !torch.vtensor<[3,4,5],f32>
  }
}

