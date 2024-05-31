module {
  func.func @test_range_float32_type(%arg0: !torch.vtensor<[],f32>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],f32>) -> !torch.vtensor<[2],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %0 = torch.aten.item %arg0 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %2 = torch.aten.item %arg2 : !torch.vtensor<[],f32> -> !torch.float
    %3 = torch.aten.arange.start_step %0, %1, %2, %none, %none, %none, %none : !torch.float, !torch.float, !torch.float, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2],f32>
    return %3 : !torch.vtensor<[2],f32>
  }
}

