module {
  func.func @test_training_dropout_zero_ratio(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],i1>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int1 = torch.constant.int 1
    %0 = torch.aten.FloatImplicit %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %1 = torch.aten.IntImplicit %arg2 : !torch.vtensor<[],i1> -> !torch.int
    %2 = torch.aten.eq.int %1, %int1 : !torch.int, !torch.int -> !torch.bool
    %3 = torch.aten.dropout %arg0, %0, %2 : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.bool -> !torch.vtensor<[3,4,5],f32>
    return %3 : !torch.vtensor<[3,4,5],f32>
  }
}

