module {
  func.func @test_concat_1d_axis_negative_1(%arg0: !torch.vtensor<[2],f32>, %arg1: !torch.vtensor<[2],f32>) -> !torch.vtensor<[4],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int-1 = torch.constant.int -1
    %0 = torch.prim.ListConstruct %arg0, %arg1 : (!torch.vtensor<[2],f32>, !torch.vtensor<[2],f32>) -> !torch.list<vtensor>
    %1 = torch.aten.cat %0, %int-1 : !torch.list<vtensor>, !torch.int -> !torch.vtensor<[4],f32>
    return %1 : !torch.vtensor<[4],f32>
  }
}

