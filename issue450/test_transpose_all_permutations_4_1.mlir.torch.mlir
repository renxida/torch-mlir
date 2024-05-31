module {
  func.func @test_transpose_all_permutations_4(%arg0: !torch.vtensor<[2,3,4],f32>) -> !torch.vtensor<[4,2,3],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64} {
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %int2 = torch.constant.int 2
    %0 = torch.aten.transpose.int %arg0, %int0, %int2 : !torch.vtensor<[2,3,4],f32>, !torch.int, !torch.int -> !torch.vtensor<[4,3,2],f32>
    %1 = torch.aten.transpose.int %0, %int1, %int2 : !torch.vtensor<[4,3,2],f32>, !torch.int, !torch.int -> !torch.vtensor<[4,2,3],f32>
    return %1 : !torch.vtensor<[4,2,3],f32>
  }
}

