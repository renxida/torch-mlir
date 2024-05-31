module {
  func.func @test_sce_mean_3d_log_prob(%arg0: !torch.vtensor<[3,5,2],f32>, %arg1: !torch.vtensor<[3,2],si64>) -> (!torch.vtensor<[],f32>, !torch.vtensor<[3,5,2],f32>) attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %true = torch.constant.bool true
    %none = torch.constant.none
    %int-100 = torch.constant.int -100
    %int1 = torch.constant.int 1
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %0 = torch.aten.cross_entropy_loss %arg0, %arg1, %none, %int1, %int-100, %float0.000000e00 : !torch.vtensor<[3,5,2],f32>, !torch.vtensor<[3,2],si64>, !torch.none, !torch.int, !torch.int, !torch.float -> !torch.vtensor<[],f32>
    %values, %indices = torch.aten.max.dim %arg0, %int1, %true : !torch.vtensor<[3,5,2],f32>, !torch.int, !torch.bool -> !torch.vtensor<[3,1,2],f32>, !torch.vtensor<[3,1,2],si64>
    %1 = torch.aten.sub.Tensor %arg0, %values, %float1.000000e00 : !torch.vtensor<[3,5,2],f32>, !torch.vtensor<[3,1,2],f32>, !torch.float -> !torch.vtensor<[3,5,2],f32>
    %2 = torch.aten.exp %1 : !torch.vtensor<[3,5,2],f32> -> !torch.vtensor<[3,5,2],f32>
    %3 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %4 = torch.aten.sum.dim_IntList %2, %3, %true, %none : !torch.vtensor<[3,5,2],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,1,2],f32>
    %5 = torch.aten.log %4 : !torch.vtensor<[3,1,2],f32> -> !torch.vtensor<[3,1,2],f32>
    %6 = torch.aten.sub.Tensor %1, %5, %float1.000000e00 : !torch.vtensor<[3,5,2],f32>, !torch.vtensor<[3,1,2],f32>, !torch.float -> !torch.vtensor<[3,5,2],f32>
    return %0, %6 : !torch.vtensor<[],f32>, !torch.vtensor<[3,5,2],f32>
  }
}

