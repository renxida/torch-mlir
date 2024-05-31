module {
  func.func @test_slice_default_steps(%arg0: !torch.vtensor<[20,10,5],f32>, %arg1: !torch.vtensor<[3],si64>, %arg2: !torch.vtensor<[3],si64>, %arg3: !torch.vtensor<[3],si64>) -> !torch.vtensor<[20,10,1],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %0 = torch.vtensor.literal(dense<2> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %1 = torch.vtensor.literal(dense<1> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %2 = torch.vtensor.literal(dense<0> : tensor<1xsi64>) : !torch.vtensor<[1],si64>
    %3 = torch.aten.index_select %arg1, %int0, %2 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %4 = torch.aten.item %3 : !torch.vtensor<[1],si64> -> !torch.int
    %5 = torch.aten.index_select %arg2, %int0, %2 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %6 = torch.aten.item %5 : !torch.vtensor<[1],si64> -> !torch.int
    %7 = torch.aten.index_select %arg3, %int0, %2 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %8 = torch.aten.item %7 : !torch.vtensor<[1],si64> -> !torch.int
    %9 = torch.aten.slice.Tensor %arg0, %8, %4, %6, %int1 : !torch.vtensor<[20,10,5],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,?],f32>
    %10 = torch.aten.index_select %arg1, %int0, %1 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %11 = torch.aten.item %10 : !torch.vtensor<[1],si64> -> !torch.int
    %12 = torch.aten.index_select %arg2, %int0, %1 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %13 = torch.aten.item %12 : !torch.vtensor<[1],si64> -> !torch.int
    %14 = torch.aten.index_select %arg3, %int0, %1 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %15 = torch.aten.item %14 : !torch.vtensor<[1],si64> -> !torch.int
    %16 = torch.aten.slice.Tensor %9, %15, %11, %13, %int1 : !torch.vtensor<[20,10,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,?],f32>
    %17 = torch.aten.index_select %arg1, %int0, %0 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %18 = torch.aten.item %17 : !torch.vtensor<[1],si64> -> !torch.int
    %19 = torch.aten.index_select %arg2, %int0, %0 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %20 = torch.aten.item %19 : !torch.vtensor<[1],si64> -> !torch.int
    %21 = torch.aten.index_select %arg3, %int0, %0 : !torch.vtensor<[3],si64>, !torch.int, !torch.vtensor<[1],si64> -> !torch.vtensor<[1],si64>
    %22 = torch.aten.item %21 : !torch.vtensor<[1],si64> -> !torch.int
    %23 = torch.aten.slice.Tensor %16, %22, %18, %20, %int1 : !torch.vtensor<[20,10,?],f32>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[20,10,1],f32>
    return %23 : !torch.vtensor<[20,10,1],f32>
  }
}

