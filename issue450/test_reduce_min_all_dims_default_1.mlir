

// CHECK-LABEL: func.func @test_reduce_min_all_dims_default
func.func @test_reduce_min_all_dims_default(%arg0: !torch.vtensor<[4,2],i1>) -> !torch.vtensor<[],i1> attributes {torch.onnx_meta.ir_version = 9 : si64, torch.onnx_meta.opset_version = 20 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[I0:.+]] = torch.constant.int 0
  // CHECK: %[[I1:.+]] = torch.constant.int 1
  // CHECK: %[[RANK:.+]] = torch.aten.dim %arg0 : !torch.vtensor<[4,2],i1> -> !torch.int
  // CHECK: %[[C0:.+]] = torch.constant.int 0
  // CHECK: %[[LT:.+]] = torch.aten.lt.int %[[I0]], %[[C0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL:.+]] = torch.aten.Int.bool %[[LT]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL:.+]] = torch.aten.mul.int %[[BOOL]], %[[RANK]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[A0:.+]] = torch.aten.add.int %[[I0]], %[[MUL]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LT:.+]] = torch.aten.lt.int %[[I1]], %[[C0]] : !torch.int, !torch.int -> !torch.bool
  // CHECK: %[[BOOL:.+]] = torch.aten.Int.bool %[[LT]] : !torch.bool -> !torch.int
  // CHECK: %[[MUL:.+]] = torch.aten.mul.int %[[BOOL]], %[[RANK]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[A1:.+]] = torch.aten.add.int %[[I1]], %[[MUL]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[LIST:.+]] = torch.prim.ListConstruct %[[A0]], %[[A1]]
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[MIN:.+]] = torch.aten.amin %arg0, %[[LIST]], %[[FALSE]] : !torch.vtensor<[4,2],i1>, !torch.list<int>, !torch.bool -> !torch.vtensor<[],i1>
  // CHECK: return %[[MIN]] : !torch.vtensor<[],i1>
  %0 = torch.operator "onnx.ReduceMin"(%arg0) {torch.onnx.keepdims = 0 : si64} : (!torch.vtensor<[4,2],i1>) -> !torch.vtensor<[],i1>
  return %0 : !torch.vtensor<[],i1>
}

