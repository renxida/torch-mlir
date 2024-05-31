

// CHECK-LABEL: func.func @test_reduce_max_bool_inputs
func.func @test_reduce_max_bool_inputs(%arg0: !torch.vtensor<[4,2],i1>, %arg1: !torch.vtensor<[1],si64>) -> !torch.vtensor<[4,1],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[IDX:.+]] = torch.constant.int 0
  // CHECK: %[[SZ:.+]] = torch.constant.int 0
  // CHECK: %[[SEL:.+]] = torch.aten.select.int %arg1, %[[IDX]], %[[SZ]]
  // CHECK: %[[ITEM:.+]] = torch.aten.item %[[SEL]]
  // CHECK: %[[DIM:.+]] = torch.aten.dim %arg0 : !torch.vtensor<[4,2],i1> -> !torch.int
  // CHECK: %[[C0:.+]] = torch.constant.int 0
  // CHECK: %[[LT:.+]] = torch.aten.lt.int %[[ITEM]], %[[C0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL:.+]] = torch.aten.Int.bool %[[LT]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL:.+]] = torch.aten.mul.int %[[BOOL]], %[[DIM]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[ADD:.+]] = torch.aten.add.int %[[ITEM]], %[[MUL]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LST:.+]] = torch.prim.ListConstruct %[[ADD]] : (!torch.int) -> !torch.list<int>
  // CHECK: %[[TRUE:.+]] = torch.constant.bool true
  // CHECK: %[[AMAX:.+]] = torch.aten.amax %arg0, %[[LST]], %[[TRUE]] : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[4,1],i1>
  // CHECK: return %[[AMAX]] : !torch.vtensor<[4,1],i1>
  %0 = torch.operator "onnx.ReduceMax"(%arg0, %arg1) {torch.onnx.keepdims = 1 : si64} : (!torch.vtensor<[4,2],i1>, !torch.vtensor<[1],si64>) -> !torch.vtensor<[4,1],i1>
  return %0 : !torch.vtensor<[4,1],i1>
}

