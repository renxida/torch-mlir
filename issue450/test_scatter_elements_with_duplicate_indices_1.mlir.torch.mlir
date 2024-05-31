module {
  func.func @test_scatter_elements_with_duplicate_indices(%arg0: !torch.vtensor<[1,5],f32>, %arg1: !torch.vtensor<[1,2],si64>, %arg2: !torch.vtensor<[1,2],f32>) -> !torch.vtensor<[1,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %str = torch.constant.str "add"
    %0 = torch.aten.scatter.reduce %arg0, %int1, %arg1, %arg2, %str : !torch.vtensor<[1,5],f32>, !torch.int, !torch.vtensor<[1,2],si64>, !torch.vtensor<[1,2],f32>, !torch.str -> !torch.vtensor<[1,5],f32>
    return %0 : !torch.vtensor<[1,5],f32>
  }
}

