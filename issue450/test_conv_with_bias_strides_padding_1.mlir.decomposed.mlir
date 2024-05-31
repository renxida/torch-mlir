module {
  func.func @test_conv_with_bias_strides_padding(%arg0: !torch.vtensor<[?,?,224,224],f32>, %arg1: !torch.vtensor<[64,3,7,7],f32>, %arg2: !torch.vtensor<[64],f32>) -> !torch.vtensor<[?,64,112,112],f32> attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int3 = torch.constant.int 3
    %int1 = torch.constant.int 1
    %int2 = torch.constant.int 2
    %int0 = torch.constant.int 0
    %0 = torch.prim.ListConstruct %int3, %int3 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.prim.ListConstruct %int2, %int2 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.aten.convolution %arg0, %arg1, %arg2, %2, %0, %1, %false, %3, %int1 : !torch.vtensor<[?,?,224,224],f32>, !torch.vtensor<[64,3,7,7],f32>, !torch.vtensor<[64],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[?,64,112,112],f32>
    return %4 : !torch.vtensor<[?,64,112,112],f32>
  }
}

