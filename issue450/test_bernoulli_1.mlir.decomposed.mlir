module {
  func.func @test_bernoulli(%arg0: !torch.vtensor<[10],f64>) -> !torch.vtensor<[10],f64> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 15 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int7 = torch.constant.int 7
    %none = torch.constant.none
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.vtensor.literal(dense<0.000000e+00> : tensor<10xf64>) : !torch.vtensor<[10],f64>
    %1 = torch.aten.uniform %0, %float0.000000e00, %float1.000000e00, %none : !torch.vtensor<[10],f64>, !torch.float, !torch.float, !torch.none -> !torch.vtensor<[10],f64>
    %2 = torch.aten.lt.Tensor %1, %arg0 : !torch.vtensor<[10],f64>, !torch.vtensor<[10],f64> -> !torch.vtensor<[10],i1>
    %3 = torch.aten.to.dtype %2, %int7, %false, %false, %none : !torch.vtensor<[10],i1>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[10],f64>
    return %3 : !torch.vtensor<[10],f64>
  }
}

