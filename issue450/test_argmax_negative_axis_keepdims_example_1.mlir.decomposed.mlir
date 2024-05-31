module {
  func.func @test_argmax_negative_axis_keepdims_example(%arg0: !torch.vtensor<[2,2],f32>) -> !torch.vtensor<[2,1],si64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %true = torch.constant.bool true
    %values, %indices = torch.aten.max.dim %arg0, %int1, %true : !torch.vtensor<[2,2],f32>, !torch.int, !torch.bool -> !torch.vtensor<[2,1],f32>, !torch.vtensor<[2,1],si64>
    return %indices : !torch.vtensor<[2,1],si64>
  }
}

