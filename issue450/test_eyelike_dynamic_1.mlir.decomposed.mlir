module {
  func.func @test_eyelike_dynamic(%arg0: !torch.vtensor<[3,?],f32>) -> !torch.vtensor<[3,?],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<0.000000e+00> : tensor<f64>) : !torch.vtensor<[],f64>
    %false = torch.constant.bool false
    %1 = torch.vtensor.literal(dense<1.000000e+00> : tensor<f64>) : !torch.vtensor<[],f64>
    %int-1 = torch.constant.int -1
    %int4 = torch.constant.int 4
    %int2 = torch.constant.int 2
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %2 = torch.aten.size.int %arg0, %int1 : !torch.vtensor<[3,?],f32>, !torch.int -> !torch.int
    %3 = torch.aten.arange.start_step %int0, %int2, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[2],si64>
    %4 = torch.aten.arange.start_step %int0, %2, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[?],si64>
    %5 = torch.aten.unsqueeze %3, %int-1 : !torch.vtensor<[2],si64>, !torch.int -> !torch.vtensor<[2,1],si64>
    %6 = torch.aten.eq.Tensor %5, %4 : !torch.vtensor<[2,1],si64>, !torch.vtensor<[?],si64> -> !torch.vtensor<[2,?],i1>
    %7 = torch.aten.to.dtype %1, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %8 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %9 = torch.aten.where.self %6, %7, %8 : !torch.vtensor<[2,?],i1>, !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[2,?],f32>
    %10 = torch.prim.ListConstruct %int3, %2 : (!torch.int, !torch.int) -> !torch.list<int>
    %11 = torch.aten.zeros %10, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,?],f32>
    %12 = torch.aten.slice_scatter %11, %9, %int0, %int1, %int3, %int1 : !torch.vtensor<[3,?],f32>, !torch.vtensor<[2,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,?],f32>
    return %12 : !torch.vtensor<[3,?],f32>
  }
}

