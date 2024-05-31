module {
  func.func @test_slice_default_axes_and_steps(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[1],si64>, %arg2: !torch.vtensor<[1],si64>) -> !torch.vtensor<[20,10,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg1 : !torch.vtensor<[1],si64> -> !torch.int
    %1 = torch.aten.item %arg2 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.aten.slice.Tensor %arg0, %int0, %0, %1, %int1 : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,1],f32>
    return %2 : !torch.vtensor<[20,10,1],f32>
  }
}

