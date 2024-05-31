module {
  func.func @test_sign(%arg0: !torch.vtensor<[3,4,5],f32>) -> !torch.vtensor<[3,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<-1> : tensor<si64>) : !torch.vtensor<[],si64>
    %1 = torch.vtensor.literal(dense<0> : tensor<si64>) : !torch.vtensor<[],si64>
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int6 = torch.constant.int 6
    %2 = torch.vtensor.literal(dense<1> : tensor<si64>) : !torch.vtensor<[],si64>
    %int0 = torch.constant.int 0
    %3 = torch.aten.gt.Scalar %arg0, %int0 : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,4,5],i1>
    %4 = torch.aten.lt.Scalar %arg0, %int0 : !torch.vtensor<[3,4,5],f32>, !torch.int -> !torch.vtensor<[3,4,5],i1>
    %5 = torch.aten.to.dtype %2, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %6 = torch.aten.to.dtype %1, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %7 = torch.aten.where.self %3, %5, %6 : !torch.vtensor<[3,4,5],i1>, !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[3,4,5],f32>
    %8 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],si64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %9 = torch.aten.where.self %4, %8, %7 : !torch.vtensor<[3,4,5],i1>, !torch.vtensor<[],f32>, !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[3,4,5],f32>
    return %9 : !torch.vtensor<[3,4,5],f32>
  }
}

