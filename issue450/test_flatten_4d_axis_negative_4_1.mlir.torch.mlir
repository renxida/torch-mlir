module {
  func.func @test_flatten_4d_axis_negative_4(%arg0: !torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[1,120],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %int3 = torch.constant.int 3
    %0 = torch.prims.collapse %arg0, %int0, %int3 : !torch.vtensor<[2,3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[120],f32>
    %1 = torch.aten.unsqueeze %0, %int0 : !torch.vtensor<[120],f32>, !torch.int -> !torch.vtensor<[1,120],f32>
    return %1 : !torch.vtensor<[1,120],f32>
  }
}

