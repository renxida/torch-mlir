module {
  func.func @test_squeeze_five_axes(%arg0: !torch.vtensor<[1,3,1,4,1,5,1,1],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[3,1,4,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %int4 = torch.constant.int 4
    %int6 = torch.constant.int 6
    %int7 = torch.constant.int 7
    %0 = torch.aten.squeeze.dim %arg0, %int7 : !torch.vtensor<[1,3,1,4,1,5,1,1],f32>, !torch.int -> !torch.vtensor<[1,3,1,4,1,5,1],f32>
    %1 = torch.aten.squeeze.dim %0, %int6 : !torch.vtensor<[1,3,1,4,1,5,1],f32>, !torch.int -> !torch.vtensor<[1,3,1,4,1,5],f32>
    %2 = torch.aten.squeeze.dim %1, %int4 : !torch.vtensor<[1,3,1,4,1,5],f32>, !torch.int -> !torch.vtensor<[1,3,1,4,5],f32>
    %3 = torch.aten.squeeze.dim %2, %int0 : !torch.vtensor<[1,3,1,4,5],f32>, !torch.int -> !torch.vtensor<[3,1,4,5],f32>
    return %3 : !torch.vtensor<[3,1,4,5],f32>
  }
}

