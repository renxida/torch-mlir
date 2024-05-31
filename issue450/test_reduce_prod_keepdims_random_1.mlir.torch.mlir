module {
  func.func @test_reduce_prod_keepdims_random(%arg0: !torch.vtensor<[3,2,2],f32>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[3,1,2],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 18 : si64} {
    %int3 = torch.constant.int 3
    %none = torch.constant.none
    %true = torch.constant.bool true
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[1],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.aten.lt.int %1, %int0 : !torch.int, !torch.int -> !torch.bool
    %3 = torch.aten.Int.bool %2 : !torch.bool -> !torch.int
    %4 = torch.aten.mul.int %3, %int3 : !torch.int, !torch.int -> !torch.int
    %5 = torch.aten.add.int %1, %4 : !torch.int, !torch.int -> !torch.int
    %6 = torch.aten.prod.dim_int %arg0, %5, %true, %none : !torch.vtensor<[3,2,2],f32>, !torch.int, !torch.bool, !torch.none -> !torch.vtensor<[3,1,2],f32>
    return %6 : !torch.vtensor<[3,1,2],f32>
  }
}

