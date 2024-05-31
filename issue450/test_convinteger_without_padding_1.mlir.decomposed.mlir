module {
  func.func @test_convinteger_without_padding(%arg0: !torch.vtensor<[1,1,3,3],ui8>, %arg1: !torch.vtensor<[1,1,2,2],ui8>, %arg2: !torch.vtensor<[],ui8>, %arg3: !torch.vtensor<[1],ui8>) -> !torch.vtensor<[1,1,2,2],si32> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %false = torch.constant.bool false
    %int1 = torch.constant.int 1
    %int0 = torch.constant.int 0
    %none = torch.constant.none
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %0 = torch.aten.item %arg2 : !torch.vtensor<[],ui8> -> !torch.int
    %1 = torch.aten.item %arg3 : !torch.vtensor<[1],ui8> -> !torch.int
    %2 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.prim.ListConstruct %int1, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %5 = torch.prim.ListConstruct %int0, %int0 : (!torch.int, !torch.int) -> !torch.list<int>
    %6 = torch.aten._make_per_tensor_quantized_tensor %arg0, %float1.000000e00, %0 : !torch.vtensor<[1,1,3,3],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,3,3],!torch.quint8>
    %7 = torch.aten._make_per_tensor_quantized_tensor %arg1, %float1.000000e00, %1 : !torch.vtensor<[1,1,2,2],ui8>, !torch.float, !torch.int -> !torch.vtensor<[1,1,2,2],!torch.quint8>
    %8 = torch.aten.convolution %6, %7, %none, %4, %2, %3, %false, %5, %int1 : !torch.vtensor<[1,1,3,3],!torch.quint8>, !torch.vtensor<[1,1,2,2],!torch.quint8>, !torch.none, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.list<int>, !torch.int -> !torch.vtensor<[1,1,2,2],si32>
    return %8 : !torch.vtensor<[1,1,2,2],si32>
  }
}

