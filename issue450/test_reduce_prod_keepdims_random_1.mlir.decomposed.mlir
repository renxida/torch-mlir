module {
  func.func @test_reduce_prod_keepdims_random(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %int3 = torch.constant.int 3
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg1 : !torch.vtensor<[1],si64> -> !torch.int
    %1 = torch.aten.lt.int %0, %int0 : !torch.int, !torch.int -> !torch.bool
    %2 = torch.aten.Int.bool %1 : !torch.bool -> !torch.int
    %3 = torch.aten.mul.int %2, %int3 : !torch.int, !torch.int -> !torch.int
    %4 = torch.aten.add.int %0, %3 : !torch.int, !torch.int -> !torch.int
    %5 = torch.aten.prod.dim_int %arg0, %4, %true, %none : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[3,1,2],f32>
    return %5 : !torch.vtensor<[3,1,2],f32>
  }
}

