module {
  func.func @test_sce_mean_3d(%arg0: !torch.vtensor<[3,5,2],f32>, %arg1: !torch.vtensor<[3,2],si64>) -> !torch.vtensor<[],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %int-100 = torch.constant.int -100
    %int1 = torch.constant.int 1
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %0 = torch.aten.cross_entropy_loss %arg0, %arg1, %none, %int1, %int-100, %float0.000000e00 : !torch.vtensor<[3,5,2],f32>, !torch.vtensor<[3,2],si64>, !torch.none, !torch.int, !torch.int, !torch.float -> !torch.vtensor<[],f32>
    return %0 : !torch.vtensor<[],f32>
  }
}

