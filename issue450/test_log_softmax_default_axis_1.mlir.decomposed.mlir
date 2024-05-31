module {
  func.func @test_log_softmax_default_axis(%arg0: !torch.vtensor<[1,3],f32>) -> !torch.vtensor<[1,3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %int-1 = torch.constant.int -1
    %true = torch.constant.bool true
    %values, %indices = torch.aten.max.dim %arg0, %int-1, %true : !torch.vtensor<[1,3],f32>, !torch.int, !torch.bool -> !torch.vtensor<[1,1],f32>, !torch.vtensor<[1,1],si64>
    %0 = torch.aten.sub.Tensor %arg0, %values, %float1.000000e00 : !torch.vtensor<[1,3],f32>, !torch.vtensor<[1,1],f32>, !torch.float -> !torch.vtensor<[1,3],f32>
    %1 = torch.aten.exp %0 : !torch.vtensor<[1,3],f32> -> !torch.vtensor<[1,3],f32>
    %2 = torch.prim.ListConstruct %int-1 : (!torch.int) -> !torch.list<int>
    %3 = torch.aten.sum.dim_IntList %1, %2, %true, %none : !torch.vtensor<[1,3],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1],f32>
    %4 = torch.aten.log %3 : !torch.vtensor<[1,1],f32> -> !torch.vtensor<[1,1],f32>
    %5 = torch.aten.sub.Tensor %0, %4, %float1.000000e00 : !torch.vtensor<[1,3],f32>, !torch.vtensor<[1,1],f32>, !torch.float -> !torch.vtensor<[1,3],f32>
    return %5 : !torch.vtensor<[1,3],f32>
  }
}

