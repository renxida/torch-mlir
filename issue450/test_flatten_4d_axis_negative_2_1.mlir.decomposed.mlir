module {
  func.func @test_flatten_4d_axis_negative_2(%arg0: !torch.vtensor<[2,3,4,5],f32>) -> !torch.vtensor<[6,20],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %int2 = torch.constant.int 2
    %int3 = torch.constant.int 3
    %0 = torch.prims.collapse %arg0, %int2, %int3 : !torch.vtensor<[2,3,4,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[2,3,20],f32>
    %1 = torch.prims.collapse %0, %int0, %int1 : !torch.vtensor<[2,3,20],f32>, !torch.int, !torch.int -> !torch.vtensor<[6,20],f32>
    return %1 : !torch.vtensor<[6,20],f32>
  }
}

