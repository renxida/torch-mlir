module {
  func.func @test_top_k(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[1],si64>) -> (!torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>) attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64} {
    %int1 = torch.constant.int 1
    %true = torch.constant.bool true
    %0 = torch.aten.item %arg1 : !torch.vtensor<[1],si64> -> !torch.int
    %values, %indices = torch.aten.topk %arg0, %0, %int1, %true, %true : !torch.vtensor<[3,4],f32>, !torch.int, !torch.int, !torch.bool, !torch.bool -> !torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>
    return %values, %indices : !torch.vtensor<[3,3],f32>, !torch.vtensor<[3,3],si64>
  }
}

