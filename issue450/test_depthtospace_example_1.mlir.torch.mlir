module {
  func.func @test_depthtospace_example(%arg0: !torch.vtensor<[1,8,2,3],f32>) -> !torch.vtensor<[1,2,4,6],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %int6 = torch.constant.int 6
    %int5 = torch.constant.int 5
    %int4 = torch.constant.int 4
    %int3 = torch.constant.int 3
    %int2 = torch.constant.int 2
    %int1 = torch.constant.int 1
    %0 = torch.prim.ListConstruct %int1, %int2, %int2, %int2, %int2, %int3 : (!torch.int, !torch.int, !torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %1 = torch.aten.reshape %arg0, %0 : !torch.vtensor<[1,8,2,3],f32>, !torch.list<int> -> !torch.vtensor<[1,2,2,2,2,3],f32>
    %2 = torch.aten.transpose.int %1, %int1, %int3 : !torch.vtensor<[1,2,2,2,2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[1,2,2,2,2,3],f32>
    %3 = torch.aten.transpose.int %2, %int2, %int4 : !torch.vtensor<[1,2,2,2,2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[1,2,2,2,2,3],f32>
    %4 = torch.aten.transpose.int %3, %int4, %int5 : !torch.vtensor<[1,2,2,2,2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[1,2,2,2,3,2],f32>
    %5 = torch.prim.ListConstruct %int1, %int2, %int4, %int6 : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
    %6 = torch.aten.reshape %4, %5 : !torch.vtensor<[1,2,2,2,3,2],f32>, !torch.list<int> -> !torch.vtensor<[1,2,4,6],f32>
    return %6 : !torch.vtensor<[1,2,4,6],f32>
  }
}

