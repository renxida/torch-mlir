module {
  func.func @test_split_2d_uneven_split_opset18(%arg0: !torch.vtensor<[2,8],f32>) -> (!torch.vtensor<[2,3],f32>, !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,2],f32>) attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %int8 = torch.constant.int 8
    %int3 = torch.constant.int 3
    %0 = torch.aten.slice.Tensor %arg0, %int1, %int0, %int3, %int1 : !torch.vtensor<[2,8],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,3],f32>
    %1 = torch.aten.slice.Tensor %arg0, %int1, %int3, %int6, %int1 : !torch.vtensor<[2,8],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,3],f32>
    %2 = torch.aten.slice.Tensor %arg0, %int1, %int6, %int8, %int1 : !torch.vtensor<[2,8],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,2],f32>
    return %0, %1, %2 : !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,3],f32>, !torch.vtensor<[2,2],f32>
  }
}

