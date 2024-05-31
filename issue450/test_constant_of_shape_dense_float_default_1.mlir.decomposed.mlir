module {
  func.func @test_constant_of_shape_dense_float_default() -> !torch.vtensor<[2,3,4],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int6 = torch.constant.int 6
    %0 = torch.vtensor.literal(dense<0.000000e+00> : tensor<f64>) : !torch.vtensor<[],f64>
    %int2 = torch.constant.int 2
    %int3 = torch.constant.int 3
    %int4 = torch.constant.int 4
    %1 = torch.prim.ListConstruct %int2, %int3, %int4 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %2 = torch.aten.to.dtype %0, %int6, %false, %false, %none : !torch.vtensor<[],f64>, !torch.int, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[],f32>
    %3 = torch.aten.broadcast_to %2, %1 : !torch.vtensor<[],f32>, !torch.list<int> -> !torch.vtensor<[2,3,4],f32>
    return %3 : !torch.vtensor<[2,3,4],f32>
  }
}

