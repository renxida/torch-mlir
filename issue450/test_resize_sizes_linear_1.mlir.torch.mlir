module {
  func.func @test_resize_sizes_linear(%arg0: !torch.vtensor<[1,1,2,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[?,?,?,?],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int3 = torch.constant.int 3
    %none = torch.constant.none
    %int0 = torch.constant.int 0
    %false = torch.constant.bool false
    %str = torch.constant.str "bilinear"
    %int2 = torch.constant.int 2
    %0 = torch.aten.select.int %arg1, %int0, %int2 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.aten.select.int %arg1, %int0, %int3 : !torch.vtensor<[4],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[1],si64> -> !torch.int
    %4 = torch.prim.ListConstruct %1, %3 : (!torch.int, !torch.int) -> !torch.list<int>
    %5 = torch.aten.__interpolate.size_list_scale_list %arg0, %4, %none, %str, %false, %none, %false : !torch.vtensor<[1,1,2,4],f32>, !torch.list<int>, !torch.none, !torch.str, !torch.bool, !torch.none, !torch.bool -> !torch.vtensor<[?,?,?,?],f32>
    return %5 : !torch.vtensor<[?,?,?,?],f32>
  }
}

