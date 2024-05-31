module {
  func.func @test_instancenorm(%arg0: !torch.vtensor<[1,2,1,3],f32>, %arg1: !torch.vtensor<[2],f32>, %arg2: !torch.vtensor<[2],f32>) -> !torch.vtensor<[1,2,1,3],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %none = torch.constant.none
    %true = torch.constant.bool true
    %float9.999990e-06 = torch.constant.float 9.9999997473787516E-6
    %int2 = torch.constant.int 2
    %int3 = torch.constant.int 3
    %0 = torch.prim.ListConstruct %int2, %int3 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.sum.dim_IntList %arg0, %0, %true, %none : !torch.vtensor<[1,2,1,3],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,2,1,1],f32>
    %2 = torch.aten.div.Scalar %1, %int3 : !torch.vtensor<[1,2,1,1],f32>, !torch.int -> !torch.vtensor<[1,2,1,1],f32>
    %3 = torch.prim.ListConstruct %int1, %int2, %int1, %int3 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %4 = torch.aten.broadcast_to %2, %3 : !torch.vtensor<[1,2,1,1],f32>, !torch.list<int> -> !torch.vtensor<[1,2,1,3],f32>
    %5 = torch.aten.sub.Tensor %arg0, %4, %int1 : !torch.vtensor<[1,2,1,3],f32>, !torch.vtensor<[1,2,1,3],f32>, !torch.int -> !torch.vtensor<[1,2,1,3],f32>
    %6 = torch.aten.mul.Tensor %5, %5 : !torch.vtensor<[1,2,1,3],f32>, !torch.vtensor<[1,2,1,3],f32> -> !torch.vtensor<[1,2,1,3],f32>
    %7 = torch.aten.sum.dim_IntList %6, %0, %true, %none : !torch.vtensor<[1,2,1,3],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[1,2,1,1],f32>
    %8 = torch.aten.div.Scalar %7, %int3 : !torch.vtensor<[1,2,1,1],f32>, !torch.int -> !torch.vtensor<[1,2,1,1],f32>
    %9 = torch.aten.add.Scalar %8, %float9.999990e-06, %int1 : !torch.vtensor<[1,2,1,1],f32>, !torch.float, !torch.int -> !torch.vtensor<[1,2,1,1],f32>
    %10 = torch.aten.rsqrt %9 : !torch.vtensor<[1,2,1,1],f32> -> !torch.vtensor<[1,2,1,1],f32>
    %11 = torch.prim.ListConstruct %int1, %int2, %int1, %int3 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %12 = torch.aten.broadcast_to %10, %11 : !torch.vtensor<[1,2,1,1],f32>, !torch.list<int> -> !torch.vtensor<[1,2,1,3],f32>
    %13 = torch.aten.mul.Tensor %5, %12 : !torch.vtensor<[1,2,1,3],f32>, !torch.vtensor<[1,2,1,3],f32> -> !torch.vtensor<[1,2,1,3],f32>
    %14 = torch.aten.unsqueeze %arg1, %int0 : !torch.vtensor<[2],f32>, !torch.int -> !torch.vtensor<[1,2],f32>
    %15 = torch.aten.unsqueeze %14, %int2 : !torch.vtensor<[1,2],f32>, !torch.int -> !torch.vtensor<[1,2,1],f32>
    %16 = torch.aten.unsqueeze %15, %int3 : !torch.vtensor<[1,2,1],f32>, !torch.int -> !torch.vtensor<[1,2,1,1],f32>
    %17 = torch.prim.ListConstruct %int1, %int2, %int1, %int3 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %18 = torch.aten.broadcast_to %16, %17 : !torch.vtensor<[1,2,1,1],f32>, !torch.list<int> -> !torch.vtensor<[1,2,1,3],f32>
    %19 = torch.aten.unsqueeze %arg2, %int0 : !torch.vtensor<[2],f32>, !torch.int -> !torch.vtensor<[1,2],f32>
    %20 = torch.aten.unsqueeze %19, %int2 : !torch.vtensor<[1,2],f32>, !torch.int -> !torch.vtensor<[1,2,1],f32>
    %21 = torch.aten.unsqueeze %20, %int3 : !torch.vtensor<[1,2,1],f32>, !torch.int -> !torch.vtensor<[1,2,1,1],f32>
    %22 = torch.prim.ListConstruct %int1, %int2, %int1, %int3 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %23 = torch.aten.broadcast_to %21, %22 : !torch.vtensor<[1,2,1,1],f32>, !torch.list<int> -> !torch.vtensor<[1,2,1,3],f32>
    %24 = torch.aten.mul.Tensor %13, %18 : !torch.vtensor<[1,2,1,3],f32>, !torch.vtensor<[1,2,1,3],f32> -> !torch.vtensor<[1,2,1,3],f32>
    %25 = torch.aten.add.Tensor %24, %23, %int1 : !torch.vtensor<[1,2,1,3],f32>, !torch.vtensor<[1,2,1,3],f32>, !torch.int -> !torch.vtensor<[1,2,1,3],f32>
    return %25 : !torch.vtensor<[1,2,1,3],f32>
  }
}

