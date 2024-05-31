module {
  func.func @test_slice(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[2],si64>, %arg2: !torch.vtensor<[2],si64>, %arg3: !torch.vtensor<[2],si64>, %arg4: !torch.vtensor<[2],si64>) -> !torch.vtensor<[3,10,5],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<1> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %int0 = torch.constant.int 0
    %1 = torch.vtensor.literal(dense<0> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %2 = torch.aten.index_select %arg1, %int0, %1 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[1],si64> -> !torch.int
    %4 = torch.aten.index_select %arg2, %int0, %1 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %5 = torch.aten.item %4 : !torch.vtensor<[1],si64> -> !torch.int
    %6 = torch.aten.index_select %arg3, %int0, %1 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %7 = torch.aten.item %6 : !torch.vtensor<[1],si64> -> !torch.int
    %8 = torch.aten.index_select %arg4, %int0, %1 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %9 = torch.aten.item %8 : !torch.vtensor<[1],si64> -> !torch.int
    %10 = torch.aten.slice.Tensor %arg0, %7, %3, %5, %9 : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[?,10,5],f32>
    %11 = torch.aten.index_select %arg1, %int0, %0 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %12 = torch.aten.item %11 : !torch.vtensor<[1],si64> -> !torch.int
    %13 = torch.aten.index_select %arg2, %int0, %0 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %14 = torch.aten.item %13 : !torch.vtensor<[1],si64> -> !torch.int
    %15 = torch.aten.index_select %arg3, %int0, %0 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %16 = torch.aten.item %15 : !torch.vtensor<[1],si64> -> !torch.int
    %17 = torch.aten.index_select %arg4, %int0, %0 : !torch.vtensor<[2],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %18 = torch.aten.item %17 : !torch.vtensor<[1],si64> -> !torch.int
    %19 = torch.aten.slice.Tensor %10, %16, %12, %14, %18 : !torch.vtensor<[?,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[3,10,5],f32>
    return %19 : !torch.vtensor<[3,10,5],f32>
  }
}

