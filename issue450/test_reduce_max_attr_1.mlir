

func.func @test_reduce_max_attr(%arg0: !torch.vtensor<[4,2],i1>) -> !torch.vtensor<[4],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[INT1:.+]] = torch.constant.int 1
  // CHECK: %[[DIM:.+]] = torch.aten.dim %arg0 : !torch.vtensor<[4,2],i1> -> !torch.int
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[LT:.+]] = torch.aten.lt.int %[[INT1]], %[[INT0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL:.+]] = torch.aten.Int.bool %[[LT]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL:.+]] = torch.aten.mul.int %[[BOOL]], %[[DIM]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[ADD:.+]] = torch.aten.add.int %[[INT1]], %[[MUL]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LIST:.+]] = torch.prim.ListConstruct %[[ADD]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[AMAX:.+]] = torch.aten.amax %arg0, %[[LIST]], %[[FALSE]] : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[4],i1>
  // CHECK: return %[[AMAX]]
  %0 = torch.operator "onnx.ReduceMax"(%arg0) {torch.onnx.keepdims = 0 : si64, torch.onnx.axes=[1 : si64]} : (!torch.vtensor<[4,2],i1>) -> !torch.vtensor<[4],i1>
  return %0 : !torch.vtensor<[4],i1>
}

