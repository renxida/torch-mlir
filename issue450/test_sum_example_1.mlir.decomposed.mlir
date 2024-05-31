module {
  func.func @test_sum_example(%arg0: !torch.vtensor<[3],f32>, %arg1: !torch.vtensor<[3],f32>, %arg2: !torch.vtensor<[3],f32>, %arg3: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.aten.add.Tensor %arg0, %arg1, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    %1 = torch.aten.add.Tensor %0, %arg2, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    %2 = torch.aten.add.Tensor %1, %arg3, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    return %2 : !torch.vtensor<[3],f32>
  }
}

