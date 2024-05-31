module {
  func.func @test_slice_default_axes_and_slices(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[3],si64>, %arg2: !torch.vtensor<[3],si64>) -> !torch.vtensor<[20,10,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<2> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %1 = torch.vtensor.literal(dense<1> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %2 = torch.vtensor.literal(dense<0> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %3 = torch.aten.index_select %arg1, %int0, %2 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %4 = torch.aten.item %3 : !torch.vtensor<[1],si64> -> !torch.int
    %5 = torch.aten.index_select %arg2, %int0, %2 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %6 = torch.aten.item %5 : !torch.vtensor<[1],si64> -> !torch.int
    %7 = torch.aten.slice.Tensor %arg0, %int0, %4, %6, %int1 : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,?],f32>
    %8 = torch.aten.index_select %arg1, %int0, %1 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %9 = torch.aten.item %8 : !torch.vtensor<[1],si64> -> !torch.int
    %10 = torch.aten.index_select %arg2, %int0, %1 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %11 = torch.aten.item %10 : !torch.vtensor<[1],si64> -> !torch.int
    %12 = torch.aten.slice.Tensor %7, %int1, %9, %11, %int1 : !torch.vtensor<[20,10,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,?],f32>
    %13 = torch.aten.index_select %arg1, %int0, %0 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %14 = torch.aten.item %13 : !torch.vtensor<[1],si64> -> !torch.int
    %15 = torch.aten.index_select %arg2, %int0, %0 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %16 = torch.aten.item %15 : !torch.vtensor<[1],si64> -> !torch.int
    %17 = torch.aten.slice.Tensor %12, %int2, %14, %16, %int1 : !torch.vtensor<[20,10,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,1],f32>
    return %17 : !torch.vtensor<[20,10,1],f32>
  }
}

