module {
  func.func @test_qlinearconv_nobias(%arg0: !torch.vtensor<[1,1,7,7],ui8>, %arg1: !torch.vtensor<[],f32>, %arg2: !torch.vtensor<[],ui8>, %arg3: !torch.vtensor<[1,1,1,1],ui8>, %arg4: !torch.vtensor<[1],f32>, %arg5: !torch.vtensor<[1],ui8>, %arg6: !torch.vtensor<[],f32>, %arg7: !torch.vtensor<[],ui8>) -> !torch.vtensor<[1,1,7,7],ui8> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 10 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int13 = torch.constant.int 13
    %none = torch.constant.none
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %0 = torch.aten.item %arg2 : !torch.vtensor<[],ui8> -> !torch.int
    %1 = torch.aten.item %arg5 : !torch.vtensor<[1],ui8> -> !torch.int
    %2 = torch.aten.item %arg7 : !torch.vtensor<[],ui8> -> !torch.int
    %3 = torch.aten.item %arg1 : !torch.vtensor<[],f32> -> !torch.float
    %4 = torch.aten.item %arg4 : !torch.vtensor<[1],f32> -> !torch.float
    %5 = torch.aten.item %arg6 : !torch.vtensor<[],f32> -> !torch.float
    %6 = torch.aten._make_per_tensor_quantized_tensor %arg0, %3, %0 : !torch.vtensor<[1,1,7,7],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.quint8>
    %7 = torch.aten._make_per_tensor_quantized_tensor %arg3, %4, %1 : !torch.vtensor<[1,1,1,1],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,1,1],!torch.quint8>
    %8 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %9 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %11 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %12 = torch.aten.convolution %6, %7, %none, %10, %8, %9, %false, %11, %int1 : !torch.vtensor<[1,1,7,7],!torch.quint8>, !torch.vtensor<[1,1,1,1],!torch.quint8>, !torch.none, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.qint32>
    %13 = torch.aten.mul.float %3, %4 : !torch.float, !torch.float -> !torch.float
    %14 = torch.aten._make_per_tensor_quantized_tensor %12, %13, %int0 : !torch.vtensor<[1,1,7,7],!torch.qint32>, !torch.float, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.qint32>
    %15 = torch.aten.dequantize.self %14 : !torch.vtensor<[1,1,7,7],!torch.qint32> -> !torch.vtensor<[1,1,7,7],f32>
    %16 = torch.aten.quantize_per_tensor %15, %5, %2, %int13 : !torch.vtensor<[1,1,7,7],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[1,1,7,7],!torch.quint8>
    %17 = torch.aten.int_repr %16 : !torch.vtensor<[1,1,7,7],!torch.quint8> -> !torch.vtensor<[1,1,7,7],ui8>
    return %17 : !torch.vtensor<[1,1,7,7],ui8>
  }
}

