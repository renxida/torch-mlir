module {
  func.func @test_dynamicquantizelinear(%arg0: !torch.vtensor<[3,4,5],f32>) -> (!torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>) attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 11 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<2.550000e+02> : tensor<f64>) : !torch.vtensor<[],f64>
    %int6 = torch.constant.int 6
    %1 = torch.vtensor.literal(dense<0.000000e+00> : tensor<f64>) : !torch.vtensor<[],f64>
    %false = torch.constant.bool false
    %int13 = torch.constant.int 13
    %float2.550000e02 = torch.constant.float 2.550000e+02
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %2 = torch.aten.max %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[],f32>
    %3 = torch.aten.min %arg0 : !torch.vtensor<[3,4,5],f32> -> !torch.vtensor<[],f32>
    %4 = torch.aten.to.dtype %1, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %5 = torch.aten.maximum %2, %4 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
    %6 = torch.aten.minimum %3, %4 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
    %7 = torch.aten.sub.Tensor %5, %6, %int1 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32>, !torch.int -> !torch.vtensor<[],f32>
    %8 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %9 = torch.aten.div.Tensor %7, %8 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
    %10 = torch.aten.div.Tensor %3, %9 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
    %11 = torch.aten.sub.Tensor %4, %10, %int1 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32>, !torch.int -> !torch.vtensor<[],f32>
    %12 = torch.aten.clamp %11, %float0.000000e00, %float2.550000e02 : !torch.vtensor<[],f32>, !torch.float, !torch.float -> !torch.vtensor<[],f32>
    %13 = torch.aten.round %12 : !torch.vtensor<[],f32> -> !torch.vtensor<[],f32>
    %14 = torch.aten.to.dtype %13, %int13, %false, %false, %none : !torch.vtensor<[],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],ui8>
    %15 = torch.aten.item %14 : !torch.vtensor<[],ui8> -> !torch.int
    %16 = torch.aten.item %9 : !torch.vtensor<[],f32> -> !torch.float
    %17 = torch.aten.quantize_per_tensor %arg0, %16, %15, %int13 : !torch.vtensor<[3,4,5],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[3,4,5],!torch.quint8>
    %18 = torch.aten.int_repr %17 : !torch.vtensor<[3,4,5],!torch.quint8> -> !torch.vtensor<[3,4,5],ui8>
    return %18, %9, %14 : !torch.vtensor<[3,4,5],ui8>, !torch.vtensor<[],f32>, !torch.vtensor<[],ui8>
  }
}

