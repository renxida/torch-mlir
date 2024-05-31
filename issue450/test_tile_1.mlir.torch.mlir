module {
  func.func @test_tile(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,12,4],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.select.int %arg1, %int0, %int0 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.aten.select.int %arg1, %int0, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[1],si64> -> !torch.int
    %4 = torch.aten.select.int %arg1, %int0, %int2 : !torch.vtensor<[3],si64>, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %5 = torch.aten.item %4 : !torch.vtensor<[1],si64> -> !torch.int
    %6 = torch.prim.ListConstruct %1, %3, %5 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %7 = torch.aten.tile %arg0, %6 : !torch.vtensor<[2,3,4],f32>, !torch.list<int> -> !torch.vtensor<[2,12,4],f32>
    return %7 : !torch.vtensor<[2,12,4],f32>
  }
}

