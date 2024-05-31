module {
  func.func @test_range_int32_type(%arg0: !torch.vtensor<[],si32>, %arg1: !torch.vtensor<[],si32>, %arg2: !torch.vtensor<[],si32>) -> !torch.vtensor<[2],si32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %0 = torch.aten.item %arg0 : !torch.vtensor<[],si32> -> !torch.int
    %1 = torch.aten.item %arg1 : !torch.vtensor<[],si32> -> !torch.int
    %2 = torch.aten.item %arg2 : !torch.vtensor<[],si32> -> !torch.int
    %3 = torch.aten.arange.start_step %0, %1, %2, %none, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2],si32>
    return %3 : !torch.vtensor<[2],si32>
  }
}

