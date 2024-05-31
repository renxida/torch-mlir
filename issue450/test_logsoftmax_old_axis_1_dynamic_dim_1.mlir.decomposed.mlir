module {
  func.func @test_logsoftmax_old_axis_1_dynamic_dim(%arg0: !torch.vtensor<[3,4,?],f32>) -> !torch.vtensor<[3,4,?],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int0 = torch.constant.int 0
    %int4 = torch.constant.int 4
    %none = torch.constant.none
    %float1.000000e00 = torch.constant.float 1.000000e+00
    %true = torch.constant.bool true
    %int1 = torch.constant.int 1
    %int3 = torch.constant.int 3
    %int-1 = torch.constant.int -1
    %0 = torch.prim.ListConstruct %int3, %int-1 : (!torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.view %arg0, %0 : !torch.vtensor<[3,4,?],f32>, !torch.list<int> -> !torch.vtensor<[3,?],f32>
    %values, %indices = torch.aten.max.dim %1, %int1, %true : !torch.vtensor<[3,?],f32>, !torch.int, !torch.bool -> !torch.vtensor<[3,1],f32>, !torch.vtensor<[3,1],si64>
    %2 = torch.aten.sub.Tensor %1, %values, %float1.000000e00 : !torch.vtensor<[3,?],f32>, !torch.vtensor<[3,1],f32>, !torch.float -> !torch.vtensor<[3,?],f32>
    %3 = torch.aten.exp %2 : !torch.vtensor<[3,?],f32> -> !torch.vtensor<[3,?],f32>
    %4 = torch.prim.ListConstruct %int1 : (!torch.int) -> !torch.list<int>
    %5 = torch.aten.sum.dim_IntList %3, %4, %true, %none : !torch.vtensor<[3,?],f32>, !torch.list<int>, !torch.bool, !torch.none -> !torch.vtensor<[3,1],f32>
    %6 = torch.aten.log %5 : !torch.vtensor<[3,1],f32> -> !torch.vtensor<[3,1],f32>
    %7 = torch.aten.sub.Tensor %2, %6, %float1.000000e00 : !torch.vtensor<[3,?],f32>, !torch.vtensor<[3,1],f32>, !torch.float -> !torch.vtensor<[3,?],f32>
    %8 = torch.aten.size.int %7, %int1 : !torch.vtensor<[3,?],f32>, !torch.int -> !torch.int
    %9 = torch.prim.ListConstruct %int3, %int4, %int0 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.aten.view %7, %9 : !torch.vtensor<[3,?],f32>, !torch.list<int> -> !torch.vtensor<[3,4,?],f32>
    return %10 : !torch.vtensor<[3,4,?],f32>
  }
}

