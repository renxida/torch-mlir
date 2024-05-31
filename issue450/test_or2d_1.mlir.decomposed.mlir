module {
  func.func @test_or2d(%arg0: !torch.vtensor<[3,4],i1>, %arg1: !torch.vtensor<[3,4],i1>) -> !torch.vtensor<[3,4],i1> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 7 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.bitwise_or.Tensor %arg0, %arg1 : !torch.vtensor<[3,4],i1>, !torch.vtensor<[3,4],i1> -> !torch.vtensor<[3,4],i1>
    return %0 : !torch.vtensor<[3,4],i1>
  }
  func.func @test_identity(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 14 : si64, torch.onnx_meta.opset_version = 14 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    return %arg0 : !torch.vtensor<[3,4],f32>
  }
  func.func @test_mean_one_input(%arg0: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    return %arg0 : !torch.vtensor<[3],f32>
  }
  func.func @test_mean_two_inputs(%arg0: !torch.vtensor<[3],f32>, %arg1: !torch.vtensor<[3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %0 = torch.aten.add.Tensor %arg0, %arg1, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    %1 = torch.aten.div.Scalar %0, %int2 : !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    return %1 : !torch.vtensor<[3],f32>
  }
  func.func @test_isinf_negative(%arg0: !torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %floatInf = torch.constant.float 0x7FF0000000000000
    %0 = torch.aten.neg %arg0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    %1 = torch.aten.relu %0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    %2 = torch.aten.abs %1 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    %3 = torch.aten.eq.Scalar %2, %floatInf : !torch.vtensor<[6],f32>, !torch.float -> !torch.vtensor<[6],i1>
    return %3 : !torch.vtensor<[6],i1>
  }
  func.func @test_isinf_positive(%arg0: !torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %floatInf = torch.constant.float 0x7FF0000000000000
    %0 = torch.aten.relu %arg0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    %1 = torch.aten.abs %0 : !torch.vtensor<[6],f32> -> !torch.vtensor<[6],f32>
    %2 = torch.aten.eq.Scalar %1, %floatInf : !torch.vtensor<[6],f32>, !torch.float -> !torch.vtensor<[6],i1>
    return %2 : !torch.vtensor<[6],i1>
  }
  func.func @test_isnan(%arg0: !torch.vtensor<[6],f32>) -> !torch.vtensor<[6],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.aten.ne.Tensor %arg0, %arg0 : !torch.vtensor<[6],f32>, !torch.vtensor<[6],f32> -> !torch.vtensor<[6],i1>
    return %0 : !torch.vtensor<[6],i1>
  }
  func.func @test_prelu_example(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 16 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %0 = torch.aten.mul.Tensor %arg0, %arg1 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    %1 = torch.aten.lt.Scalar %arg0, %float0.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.float -> !torch.vtensor<[3,4,5],i1>
    %2 = torch.aten.where.self %1, %0, %arg0 : !torch.vtensor<[3,4,5],i1>, !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    return %2 : !torch.vtensor<[3,4,5],f32>
  }
  func.func @test_prelu_broadcast(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 16 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %0 = torch.aten.mul.Tensor %arg0, %arg1 : !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[5],f32> -> !torch.vtensor<[3,4,5],f32>
    %1 = torch.aten.lt.Scalar %arg0, %float0.000000e00 : !torch.vtensor<[3,4,5],f32>, !torch.float -> !torch.vtensor<[3,4,5],i1>
    %2 = torch.aten.where.self %1, %0, %arg0 : !torch.vtensor<[3,4,5],i1>, !torch.vtensor<[3,4,5],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    return %2 : !torch.vtensor<[3,4,5],f32>
  }
}

