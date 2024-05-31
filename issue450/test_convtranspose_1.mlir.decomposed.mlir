module {
  func.func @test_convtranspose(%arg0: !torch.vtensor<[1,1,3,3],f32>, %arg1: !torch.vtensor<[1,2,3,3],f32>) -> !torch.vtensor<[1,2,5,5],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.aten.convolution %arg0, %arg1, %none, %2, %0, %1, %true, %3, %int1 : !torch.vtensor<[1,1,3,3],f32>, !torch.vtensor<[1,2,3,3],f32>, !torch.none, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[1,2,5,5],f32>
    return %4 : !torch.vtensor<[1,2,5,5],f32>
  }
}

