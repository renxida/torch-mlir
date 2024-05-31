module {
  func.func @test_gather(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[8,10,20,40],si64>) -> !torch.vtensor<[8,10,20,40,4,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
    %int5 = torch.constant.int 5
    %int4 = torch.constant.int 4
    %int40 = torch.constant.int 40
    %int20 = torch.constant.int 20
    %int10 = torch.constant.int 10
    %int8 = torch.constant.int 8
    %int-1 = torch.constant.int -1
    %int3 = torch.constant.int 3
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.aten.lt.Scalar %arg1, %int0 : !torch.vtensor<[8,10,20,40],si64>, !torch.int -> !torch.vtensor<[8,10,20,40],i1>
    %1 = torch.aten.add.Scalar %arg1, %int3, %int1 : !torch.vtensor<[8,10,20,40],si64>, !torch.int, !torch.int -> !torch.vtensor<[8,10,20,40],si64>
    %2 = torch.aten.where.self %0, %1, %arg1 : !torch.vtensor<[8,10,20,40],i1>, !torch.vtensor<[8,10,20,40],si64>, !torch.vtensor<[8,10,20,40],si64> -> !torch.vtensor<[8,10,20,40],si64>
    %3 = torch.prim.ListConstruct %int-1 : (!torch.int) -> !torch.list<int>
    %4 = torch.aten.view %2, %3 : !torch.vtensor<[8,10,20,40],si64>, !torch.list<int> -> !torch.vtensor<[64000],si64>
    %5 = torch.aten.index_select %arg0, %int0, %4 : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.vtensor<[64000],si64> -> !torch.vtensor<[64000,4,5],f32>
    %6 = torch.prim.ListConstruct %int8, %int10, %int20, %int40, %int4, %int5 : (!torch.int, !torch.int, !torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %7 = torch.aten.view %5, %6 : !torch.vtensor<[64000,4,5],f32>, !torch.list<int> -> !torch.vtensor<[8,10,20,40,4,5],f32>
    return %7 : !torch.vtensor<[8,10,20,40,4,5],f32>
  }
}

