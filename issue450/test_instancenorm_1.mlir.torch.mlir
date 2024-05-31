module {
  func.func @test_instancenorm(%arg0: !torch.vtensor<[1,2,1,3],f32>, %arg1: !torch.vtensor<[2],f32>, %arg2: !torch.vtensor<[2],f32>) -> !torch.vtensor<[1,2,1,3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %false = torch.constant.bool false
    %float9.999990e-06 = torch.constant.float 9.9999997473787516E-6
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %0 = torch.aten.instance_norm %arg0, %arg1, %arg2, %none, %none, %true, %float0.000000e00, %float9.999990e-06, %false : !torch.vtensor<[1,2,1,3],f32>, !torch.vtensor<[2],f32>, !torch.vtensor<[2],f32>, !torch.none, !torch.none, !torch.bool, !torch.float, !torch.float, !torch.bool -> !torch.vtensor<[1,2,1,3],f32>
    return %0 : !torch.vtensor<[1,2,1,3],f32>
  }
}

