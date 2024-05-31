module {
  func.func @test_gather_scalar(%arg0: !torch.vtensor<[3,4,5],f32>, %arg1: !torch.vtensor<[],si64>) -> !torch.vtensor<[4,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
    %int3 = torch.constant.int 3
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.aten.lt.Scalar %arg1, %int0 : !torch.vtensor<[],si64>, !torch.int -> !torch.vtensor<[],i1>
    %1 = torch.aten.add.Scalar %arg1, %int3, %int1 : !torch.vtensor<[],si64>, !torch.int, !torch.int -> !torch.vtensor<[],si64>
    %2 = torch.aten.where.self %0, %1, %arg1 : !torch.vtensor<[],i1>, !torch.vtensor<[],si64>, !torch.vtensor<[],si64> -> !torch.vtensor<[],si64>
    %3 = torch.aten.unsqueeze %2, %int0 : !torch.vtensor<[],si64>, !torch.int -> !torch.vtensor<[1],si64>
    %4 = torch.aten.index_select %arg0, %int0, %3 : !torch.vtensor<[3,4,5],f32>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1,4,5],f32>
    %5 = torch.aten.squeeze %4 : !torch.vtensor<[1,4,5],f32> -> !torch.vtensor<[4,5],f32>
    return %5 : !torch.vtensor<[4,5],f32>
  }
}

