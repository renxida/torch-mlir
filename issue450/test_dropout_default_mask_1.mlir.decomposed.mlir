module {
  func.func @test_dropout_default_mask(%arg0: !torch.vtensor<[3,4,5],f32>) -> (!torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>) attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int5 = torch.constant.int 5
    %int4 = torch.constant.int 4
    %int3 = torch.constant.int 3
    %0 = torch.vtensor.literal(dense<1> : tensor<si64>) : !torch.vtensor<[],si64>
    %int11 = torch.constant.int 11
    %false = torch.constant.bool false
    %none = torch.constant.none
    %1 = torch.aten.to.dtype %0, %int11, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],i1>
    %2 = torch.prim.ListConstruct %int3, %int4, %int5 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.aten.broadcast_to %1, %2 : !torch.vtensor<[],i1>, !torch.list<int> -> !torch.vtensor<[3,4,5],i1>
    return %arg0, %3 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],i1>
  }
}

