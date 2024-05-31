module {
  func.func @test_eyelike_diagonal(%arg0: !torch.vtensor<[3,4],f32>) -> !torch.vtensor<[3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<0.000000e+00> : tensor<f64>) : !torch.vtensor<[],f64>
    %false = torch.constant.bool false
    %1 = torch.vtensor.literal(dense<1.000000e+00> : tensor<f64>) : !torch.vtensor<[],f64>
    %int-1 = torch.constant.int -1
    %int6 = torch.constant.int 6
    %none = torch.constant.none
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %int0 = torch.constant.int 0
    %2 = torch.aten.arange.start_step %int0, %int3, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3],si64>
    %3 = torch.aten.arange.start_step %int0, %int3, %int1, %int4, %none, %none, %none : !torch.int, !torch.int, !torch.int, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3],si64>
    %4 = torch.aten.unsqueeze %2, %int-1 : !torch.vtensor<[3],si64>, !torch.int -> !torch.vtensor<[3,1],si64>
    %5 = torch.aten.eq.Tensor %4, %3 : !torch.vtensor<[3,1],si64>, !torch.vtensor<[3],si64> -> !torch.vtensor<[3,3],i1>
    %6 = torch.aten.to.dtype %1, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %7 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %8 = torch.aten.where.self %5, %6, %7 : !torch.vtensor<[3,3],i1>, !torch.vtensor<[],f32>, !torch.vtensor<[],f32> -> !torch.vtensor<[3,3],f32>
    %9 = torch.prim.ListConstruct %int3, %int4 : (!torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.aten.zeros %9, %int6, %none, %none, %none : !torch.list<int>, !torch.int, !torch.none, !torch.none, !torch.none -> !torch.vtensor<[3,4],f32>
    %11 = torch.aten.slice_scatter %10, %8, %int1, %int1, %int4, %int1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,3],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,4],f32>
    return %11 : !torch.vtensor<[3,4],f32>
  }
}

