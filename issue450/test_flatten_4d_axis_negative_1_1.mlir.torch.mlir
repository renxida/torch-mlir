module {
  func.func @test_flatten_4d_axis_negative_1(%arg0: !torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[24,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int0 = torch.constant.int 0
    %int3 = torch.constant.int 3
    %0 = torch.prims.collapse %arg0, %int3, %int3 : !torch.vtensor<[2,3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[2,3,4,5],f32>
    %1 = torch.prims.collapse %0, %int0, %int2 : !torch.vtensor<[2,3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[24,5],f32>
    return %1 : !torch.vtensor<[24,5],f32>
  }
}

