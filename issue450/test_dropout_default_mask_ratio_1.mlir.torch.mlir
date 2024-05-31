module {
  func.func @test_dropout_default_mask_ratio(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[],f32>) -> (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>) attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %int11 = torch.constant.int 11
    %false = torch.constant.bool false
    %0 = torch.aten.FloatImplicit %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.dropout %arg0, %0, %false : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.bool -> !torch.vtensor<[3,4,5],f32>
    %2 = torch.aten.ones_like %arg0, %int11, %none, %none, %none, %none : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,4,5],i1>
    return %1, %2 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>
  }
}

