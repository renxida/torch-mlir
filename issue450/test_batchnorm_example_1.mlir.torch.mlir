module {
  func.func @test_batchnorm_example(%arg0: !torch.vtensor<[2,3,4,5],f32>, %arg1: !torch.vtensor<[3],f32>, %arg2: !torch.vtensor<[3],f32>, %arg3: !torch.vtensor<[3],f32>, %arg4: !torch.vtensor<[3],f32>) -> !torch.vtensor<[2,3,4,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %float8.999990e-01 = torch.constant.float 0.89999997615814208
    %float9.999990e-06 = torch.constant.float 9.9999997473787516E-6
    %0 = torch.aten.batch_norm %arg0, %arg1, %arg2, %arg3, %arg4, %false, %float8.999990e-01, %float9.999990e-06, %false : !torch.vtensor<[2,3,4,5],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.bool, !torch.float, !torch.float, !torch.bool -> !torch.vtensor<[2,3,4,5],f32>
    return %0 : !torch.vtensor<[2,3,4,5],f32>
  }
}

