module {
  func.func @test_layer_norm(%arg0: !torch.vtensor<[3,4],f32>, %arg1: !torch.vtensor<[3,4],f32>, %arg2: !torch.vtensor<[3,4],f32>) -> (!torch.vtensor<[3,4],f32>, !torch.vtensor<[1,1],f32>, !torch.vtensor<[1,1],f32>) attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int4 = torch.constant.int 4
    %int3 = torch.constant.int 3
    %int12 = torch.constant.int 12
    %none = torch.constant.none
    %true = torch.constant.bool true
    %float9.999990e-06 = torch.constant.float 9.9999997473787516E-6
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int0, %int1 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %true, %none : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1],f32>
    %2 = torch.aten.div.Scalar %1, %int12 : !torch.vtensor<[1,1],f32>, !torch.int -> !torch.vtensor<[1,1],f32>
    %3 = torch.prim.ListConstruct %int3, %int4 : (!torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.aten.broadcast_to %2, %3 : !torch.vtensor<[1,1],f32>, !torch.list<int> -> !torch.vtensor<[3,4],f32>
    %5 = torch.aten.sub.Tensor %arg0, %4, %int1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32>, !torch.int -> !torch.vtensor<[3,4],f32>
    %6 = torch.aten.mul.Tensor %5, %5 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32> -> !torch.vtensor<[3,4],f32>
    %7 = torch.aten.sum.dim_IntList %6, %0, %true, %none : !torch.vtensor<[3,4],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,1],f32>
    %8 = torch.aten.div.Scalar %7, %int12 : !torch.vtensor<[1,1],f32>, !torch.int -> !torch.vtensor<[1,1],f32>
    %9 = torch.aten.add.Scalar %8, %float9.999990e-06, %int1 : !torch.vtensor<[1,1],f32>, !torch.float, !torch.int -> !torch.vtensor<[1,1],f32>
    %10 = torch.aten.rsqrt %9 : !torch.vtensor<[1,1],f32> -> !torch.vtensor<[1,1],f32>
    %11 = torch.prim.ListConstruct %int3, %int4 : (!torch.int, !torch.int) -> !torch.list<int>
    %12 = torch.aten.broadcast_to %10, %11 : !torch.vtensor<[1,1],f32>, !torch.list<int> -> !torch.vtensor<[3,4],f32>
    %13 = torch.aten.mul.Tensor %5, %12 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32> -> !torch.vtensor<[3,4],f32>
    %14 = torch.aten.mul.Tensor %13, %arg1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32> -> !torch.vtensor<[3,4],f32>
    %15 = torch.aten.add.Tensor %14, %arg2, %int1 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[3,4],f32>, !torch.int -> !torch.vtensor<[3,4],f32>
    return %15, %2, %10 : !torch.vtensor<[3,4],f32>, !torch.vtensor<[1,1],f32>, !torch.vtensor<[1,1],f32>
  }
}

