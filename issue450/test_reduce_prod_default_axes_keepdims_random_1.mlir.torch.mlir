module {
  func.func @test_reduce_prod_default_axes_keepdims_random(%arg0: !torch.vtensor<[3,2,2],f32>) -> !torch.vtensor<[1,1,1],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %int2 = torch.constant.int 2
    %0 = torch.aten.prod.dim_int %arg0, %int0, %true, %none : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[?,?,?],f32>
    %1 = torch.aten.prod.dim_int %0, %int1, %true, %none : !torch.vtensor<[?,?,?],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[?,?,?],f32>
    %2 = torch.aten.prod.dim_int %1, %int2, %true, %none : !torch.vtensor<[?,?,?],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1],f32>
    return %2 : !torch.vtensor<[1,1,1],f32>
  }
}

