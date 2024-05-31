module {
  func.func @test_einsum_batch_matmul(%arg0: !torch.vtensor<[5,2,3],f64>, %arg1: !torch.vtensor<[5,3,4],f64>) -> !torch.vtensor<[5,2,4],f64> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 12 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int2 = torch.constant.int 2
    %int4 = torch.constant.int 4
    %int5 = torch.constant.int 5
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int0, %int1, %int2 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.permute %arg0, %0 : !torch.vtensor<[5,2,3],f64>, !torch.list<int> -> !torch.vtensor<*,f64>
    %2 = torch.prim.ListConstruct %int0, %int1, %int2 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %3 = torch.aten.permute %arg1, %2 : !torch.vtensor<[5,3,4],f64>, !torch.list<int> -> !torch.vtensor<*,f64>
    %4 = torch.aten.size.int %1, %int0 : !torch.vtensor<*,f64>, !torch.int -> !torch.int
    %5 = torch.aten.size.int %1, %int1 : !torch.vtensor<*,f64>, !torch.int -> !torch.int
    %6 = torch.aten.size.int %1, %int2 : !torch.vtensor<*,f64>, !torch.int -> !torch.int
    %7 = torch.aten.mul.int %int1, %4 : !torch.int, !torch.int -> !torch.int
    %8 = torch.aten.mul.int %int1, %5 : !torch.int, !torch.int -> !torch.int
    %9 = torch.aten.mul.int %int1, %6 : !torch.int, !torch.int -> !torch.int
    %10 = torch.prim.ListConstruct %7, %8, %9 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %11 = torch.aten.view %1, %10 : !torch.vtensor<*,f64>, !torch.list<int> -> !torch.vtensor<*,f64>
    %12 = torch.aten.size.int %3, %int0 : !torch.vtensor<*,f64>, !torch.int -> !torch.int
    %13 = torch.aten.size.int %3, %int1 : !torch.vtensor<*,f64>, !torch.int -> !torch.int
    %14 = torch.aten.size.int %3, %int2 : !torch.vtensor<*,f64>, !torch.int -> !torch.int
    %15 = torch.aten.mul.int %int1, %12 : !torch.int, !torch.int -> !torch.int
    %16 = torch.aten.mul.int %int1, %13 : !torch.int, !torch.int -> !torch.int
    %17 = torch.aten.mul.int %int1, %14 : !torch.int, !torch.int -> !torch.int
    %18 = torch.prim.ListConstruct %15, %16, %17 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %19 = torch.aten.view %3, %18 : !torch.vtensor<*,f64>, !torch.list<int> -> !torch.vtensor<*,f64>
    %20 = torch.aten.matmul %11, %19 : !torch.vtensor<*,f64>, !torch.vtensor<*,f64> -> !torch.vtensor<*,f64>
    %21 = torch.prim.ListConstruct %int5, %int2, %int4 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %22 = torch.aten.view %20, %21 : !torch.vtensor<*,f64>, !torch.list<int> -> !torch.vtensor<*,f64>
    %23 = torch.prim.ListConstruct %int0, %int1, %int2 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %24 = torch.aten.permute %22, %23 : !torch.vtensor<*,f64>, !torch.list<int> -> !torch.vtensor<[5,2,4],f64>
    return %24 : !torch.vtensor<[5,2,4],f64>
  }
}

