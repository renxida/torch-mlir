module {
  func.func @test_qlinearmatmul_2D(%arg0: !torch.vtensor<[2,4],ui8>, %arg1: !torch.vtensor<[1],f32>, %arg2: !torch.vtensor<[1],ui8>, %arg3: !torch.vtensor<[4,3],ui8>, %arg4: !torch.vtensor<[1],f32>, %arg5: !torch.vtensor<[1],ui8>, %arg6: !torch.vtensor<[1],f32>, %arg7: !torch.vtensor<[1],ui8>) -> !torch.vtensor<[2,3],ui8> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 10 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int13 = torch.constant.int 13
    %int0 = torch.constant.int 0
    %0 = torch.prim.ListConstruct  : () -> !torch.list<int>
    %1 = torch.aten.reshape %arg2, %0 : !torch.vtensor<[1],ui8>, !torch.list<int> -> !torch.vtensor<[],ui8>
    %2 = torch.aten.item %1 : !torch.vtensor<[],ui8> -> !torch.int
    %3 = torch.aten.reshape %arg5, %0 : !torch.vtensor<[1],ui8>, !torch.list<int> -> !torch.vtensor<[],ui8>
    %4 = torch.aten.item %3 : !torch.vtensor<[],ui8> -> !torch.int
    %5 = torch.aten.reshape %arg7, %0 : !torch.vtensor<[1],ui8>, !torch.list<int> -> !torch.vtensor<[],ui8>
    %6 = torch.aten.item %5 : !torch.vtensor<[],ui8> -> !torch.int
    %7 = torch.aten.reshape %arg1, %0 : !torch.vtensor<[1],f32>, !torch.list<int> -> !torch.vtensor<[],f32>
    %8 = torch.aten.item %7 : !torch.vtensor<[],f32> -> !torch.float
    %9 = torch.aten.reshape %arg4, %0 : !torch.vtensor<[1],f32>, !torch.list<int> -> !torch.vtensor<[],f32>
    %10 = torch.aten.item %9 : !torch.vtensor<[],f32> -> !torch.float
    %11 = torch.aten.reshape %arg6, %0 : !torch.vtensor<[1],f32>, !torch.list<int> -> !torch.vtensor<[],f32>
    %12 = torch.aten.item %11 : !torch.vtensor<[],f32> -> !torch.float
    %13 = torch.aten._make_per_tensor_quantized_tensor %arg0, %8, %2 : !torch.vtensor<[2,4],ui8>, !torch.float, !torch.int -> !torch.vtensor<[2,4],!torch.quint8>
    %14 = torch.aten._make_per_tensor_quantized_tensor %arg3, %10, %4 : !torch.vtensor<[4,3],ui8>, !torch.float, !torch.int -> !torch.vtensor<[4,3],!torch.quint8>
    %15 = torch.aten.mm %13, %14 : !torch.vtensor<[2,4],!torch.quint8>, !torch.vtensor<[4,3],!torch.quint8> -> !torch.vtensor<[2,3],si32>
    %16 = torch.aten.mul.float %8, %10 : !torch.float, !torch.float -> !torch.float
    %17 = torch.aten._make_per_tensor_quantized_tensor %15, %16, %int0 : !torch.vtensor<[2,3],si32>, !torch.float, !torch.int -> !torch.vtensor<[2,3],!torch.qint32>
    %18 = torch.aten.dequantize.self %17 : !torch.vtensor<[2,3],!torch.qint32> -> !torch.vtensor<[2,3],f32>
    %19 = torch.aten.quantize_per_tensor %18, %12, %6, %int13 : !torch.vtensor<[2,3],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[2,3],!torch.quint8>
    %20 = torch.aten.int_repr %19 : !torch.vtensor<[2,3],!torch.quint8> -> !torch.vtensor<[2,3],ui8>
    return %20 : !torch.vtensor<[2,3],ui8>
  }
}

