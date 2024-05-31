module {
  func.func @test_blackmanwindow(%arg0: !torch.vtensor<[],si32>) -> !torch.vtensor<[10],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %float4.200000e-01 = torch.constant.float 4.200000e-01
    %float-5.000000e-01 = torch.constant.float -5.000000e-01
    %float8.000000e-02 = torch.constant.float 8.000000e-02
    %float0.000000e00 = torch.constant.float 0.000000e+00
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %float2.000000e00 = torch.constant.float 2.000000e+00
    %float6.283190e00 = torch.constant.float 6.2831853071795862
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int6 = torch.constant.int 6
    %0 = torch.aten.to.dtype %arg0, %int6, %false, %false, %none : !torch.vtensor<[],si32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %1 = torch.aten.sub.Scalar %0, %float1.000000e00, %float1.000000e00 : !torch.vtensor<[],f32>, !torch.float, !torch.float -> !torch.vtensor<[],f32>
    %2 = torch.aten.mul.Scalar %0, %float1.000000e00 : !torch.vtensor<[],f32>, !torch.float -> !torch.vtensor<[],f32>
    %3 = torch.aten.mul.Scalar %1, %float0.000000e00 : !torch.vtensor<[],f32>, !torch.float -> !torch.vtensor<[],f32>
    %4 = torch.aten.add.Tensor %3, %2, %float1.000000e00 : !torch.vtensor<[],f32>, !torch.vtensor<[],f32>, !torch.float -> !torch.vtensor<[],f32>
    %5 = torch.aten.item %arg0 : !torch.vtensor<[],si32> -> !torch.int
    %6 = torch.aten.arange.start_step %float0.000000e00, %5, %float1.000000e00, %none, %none, %none, %none : !torch.float, !torch.int, !torch.float, !torch.none, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[10],f32>
    %7 = torch.aten.mul.Scalar %6, %float6.283190e00 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %8 = torch.aten.div.Tensor %7, %4 : !torch.vtensor<[10],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[10],f32>
    %9 = torch.aten.mul.Scalar %8, %float2.000000e00 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %10 = torch.aten.cos %8 : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
    %11 = torch.aten.cos %9 : !torch.vtensor<[10],f32> -> !torch.vtensor<[10],f32>
    %12 = torch.aten.mul.Scalar %10, %float-5.000000e-01 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %13 = torch.aten.mul.Scalar %11, %float8.000000e-02 : !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    %14 = torch.aten.add.Scalar %12, %float4.200000e-01, %float1.000000e00 : !torch.vtensor<[10],f32>, !torch.float, !torch.float -> !torch.vtensor<[10],f32>
    %15 = torch.aten.add.Tensor %14, %13, %float1.000000e00 : !torch.vtensor<[10],f32>, !torch.vtensor<[10],f32>, !torch.float -> !torch.vtensor<[10],f32>
    return %15 : !torch.vtensor<[10],f32>
  }
}

