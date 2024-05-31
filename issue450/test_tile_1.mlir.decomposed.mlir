module {
  func.func @test_tile(%arg0: !torch.vtensor<[2,3,4],f32>, %arg1: !torch.vtensor<[3],si64>) -> !torch.vtensor<[2,12,4],f32> attributes {torch.onnx_meta.ir_version = 8 : si64, torch.onnx_meta.opset_version = 6 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int-1 = torch.constant.int -1
    %int4 = torch.constant.int 4
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int0 = torch.constant.int 0
    %int1 = torch.constant.int 1
    %0 = torch.aten.slice.Tensor %arg1, %int0, %int0, %int1, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %1 = torch.aten.item %0 : !torch.vtensor<[1],si64> -> !torch.int
    %2 = torch.aten.slice.Tensor %arg1, %int0, %int1, %int2, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %3 = torch.aten.item %2 : !torch.vtensor<[1],si64> -> !torch.int
    %4 = torch.aten.slice.Tensor %arg1, %int0, %int2, %int3, %int1 : !torch.vtensor<[3],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[1],si64>
    %5 = torch.aten.item %4 : !torch.vtensor<[1],si64> -> !torch.int
    %6 = torch.aten.unsqueeze %arg0, %int0 : !torch.vtensor<[2,3,4],f32>, !torch.int -> !torch.vtensor<[1,2,3,4],f32>
    %7 = torch.aten.unsqueeze %6, %int2 : !torch.vtensor<[1,2,3,4],f32>, !torch.int -> !torch.vtensor<[1,2,1,3,4],f32>
    %8 = torch.aten.unsqueeze %7, %int4 : !torch.vtensor<[1,2,1,3,4],f32>, !torch.int -> !torch.vtensor<[1,2,1,3,1,4],f32>
    %9 = torch.prim.ListConstruct %1, %int2, %3, %int3, %5, %int4 : (!torch.int, !torch.int, !torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %10 = torch.aten.broadcast_to %8, %9 : !torch.vtensor<[1,2,1,3,1,4],f32>, !torch.list<int> -> !torch.vtensor<[?,2,?,3,?,4],f32>
    %11 = torch.aten.size.int %10, %int2 : !torch.vtensor<[?,2,?,3,?,4],f32>, !torch.int -> !torch.int
    %12 = torch.aten.size.int %10, %int4 : !torch.vtensor<[?,2,?,3,?,4],f32>, !torch.int -> !torch.int
    %13 = torch.prim.ListConstruct %int-1, %11, %int3, %12, %int4 : (!torch.int, !torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %14 = torch.aten.view %10, %13 : !torch.vtensor<[?,2,?,3,?,4],f32>, !torch.list<int> -> !torch.vtensor<[?,?,3,?,4],f32>
    %15 = torch.aten.size.int %14, %int0 : !torch.vtensor<[?,?,3,?,4],f32>, !torch.int -> !torch.int
    %16 = torch.aten.size.int %14, %int3 : !torch.vtensor<[?,?,3,?,4],f32>, !torch.int -> !torch.int
    %17 = torch.prim.ListConstruct %15, %int-1, %16, %int4 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %18 = torch.aten.view %14, %17 : !torch.vtensor<[?,?,3,?,4],f32>, !torch.list<int> -> !torch.vtensor<[?,?,?,4],f32>
    %19 = torch.aten.size.int %18, %int0 : !torch.vtensor<[?,?,?,4],f32>, !torch.int -> !torch.int
    %20 = torch.aten.size.int %18, %int1 : !torch.vtensor<[?,?,?,4],f32>, !torch.int -> !torch.int
    %21 = torch.prim.ListConstruct %19, %20, %int-1 : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %22 = torch.aten.view %18, %21 : !torch.vtensor<[?,?,?,4],f32>, !torch.list<int> -> !torch.vtensor<[2,12,4],f32>
    return %22 : !torch.vtensor<[2,12,4],f32>
  }
}

