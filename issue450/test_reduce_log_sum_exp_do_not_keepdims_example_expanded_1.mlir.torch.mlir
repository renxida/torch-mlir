module {
  func.func @test_reduce_log_sum_exp_do_not_keepdims_example_expanded(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %int0 = torch.constant.int 0
    %int7 = torch.constant.int 7
    %none = torch.constant.none
    %false = torch.constant.bool false
    %0 = torch.aten.to.dtype %arg0, %int7, %false, %false, %none : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,2,2],f64>
    %1 = torch.aten.exp %0 : !torch.vtensor<[3,2,2],f64> -> !torch.vtensor<[3,2,2],f64>
    %2 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[1],si64> -> !torch.int
    %4 = torch.prim.ListConstruct %3 : (!torch.int) -> !torch.list<int>
    %5 = torch.aten.sum.dim_IntList %1, %4, %false, %none : !torch.vtensor<[3,2,2],f64>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f64>
    %6 = torch.aten.log %5 : !torch.vtensor<[3,2],f64> -> !torch.vtensor<[3,2],f64>
    %7 = torch.aten.to.dtype %6, %int6, %false, %false, %none : !torch.vtensor<[3,2],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[3,2],f32>
    return %7 : !torch.vtensor<[3,2],f32>
  }
}

