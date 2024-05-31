module {
  func.func @test_compress_default_axis(%arg0: !torch.vtensor<[2,3],f32>) -> !torch.vtensor<[3],f32> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 9 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int-1 = torch.constant.int -1
    %int0 = torch.constant.int 0
    %0 = torch.vtensor.literal(dense<[0, 1, 0, 1, 0, 1]> : tensor<6xsi64>) : !torch.vtensor<[6],si64>
    %1 = torch.aten.nonzero %0 : !torch.vtensor<[6],si64> -> !torch.vtensor<[3],si64>
    %2 = torch.prim.ListConstruct %int-1 : (!torch.int) -> !torch.list<int>
    %3 = torch.aten.view %arg0, %2 : !torch.vtensor<[2,3],f32>, !torch.list<int> -> !torch.vtensor<[6],f32>
    %4 = torch.aten.index_select %3, %int0, %1 : !torch.vtensor<[6],f32>, !torch.int, !torch.vtensor<[3],si64> -> !torch.vtensor<[3],f32>
    return %4 : !torch.vtensor<[3],f32>
  }
}

