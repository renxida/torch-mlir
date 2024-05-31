

// CHECK-LABEL: @test_depthtospace_crd_mode_example
func.func @test_depthtospace_crd_mode_example(%arg0: !torch.vtensor<[1,8,2,3],f32>) -> !torch.vtensor<[1,2,4,6],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 13 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[SIZE:.*]] = torch.aten.size.int %arg0, %[[C0]] : !torch.vtensor<[1,8,2,3],f32>, !torch.int -> !torch.int
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[SIZE_0:.*]] = torch.aten.size.int %arg0, %[[C1]] : !torch.vtensor<[1,8,2,3],f32>, !torch.int -> !torch.int
  // CHECK: %[[C2:.*]] = torch.constant.int 2
  // CHECK: %[[SIZE_1:.*]] = torch.aten.size.int %arg0, %[[C2]] : !torch.vtensor<[1,8,2,3],f32>, !torch.int -> !torch.int
  // CHECK: %[[C3:.*]] = torch.constant.int 3
  // CHECK: %[[SIZE_2:.*]] = torch.aten.size.int %arg0, %[[C3]] : !torch.vtensor<[1,8,2,3],f32>, !torch.int -> !torch.int
  // CHECK: %[[C2_0:.*]] = torch.constant.int 2
  // CHECK: %[[C4:.*]] = torch.constant.int 4
  // CHECK: %[[DIV:.*]] = torch.aten.div.int %[[SIZE_0]], %[[C4]] : !torch.int, !torch.int -> !torch.float
  // CHECK: %[[INT:.*]] = torch.aten.Int.float %[[DIV]] : !torch.float -> !torch.int
  // CHECK: %[[RESHAPE_LIST:.*]] = torch.prim.ListConstruct %[[SIZE]], %[[C2_0]], %[[C2_0]], %[[INT]], %[[SIZE_1]], %[[SIZE_2]] : (!torch.int, !torch.int, !torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[RESHAPE:.*]] = torch.aten.reshape %arg0, %[[RESHAPE_LIST]] : !torch.vtensor<[1,8,2,3],f32>, !torch.list<int> -> !torch.vtensor<[1,2,2,2,2,3],f32>
  // CHECK: %[[C2_1:.*]] = torch.constant.int 2
  // CHECK: %[[C4_0:.*]] = torch.constant.int 4
  // CHECK: %[[TRANSPOSE:.*]] = torch.aten.transpose.int %[[RESHAPE]], %[[C2_1]], %[[C4_0]] : !torch.vtensor<[1,2,2,2,2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[1,2,2,2,2,3],f32>
  // CHECK: %[[C3_0:.*]] = torch.constant.int 3
  // CHECK: %[[C4_1:.*]] = torch.constant.int 4
  // CHECK: %[[TRANSPOSE_1:.*]] = torch.aten.transpose.int %[[TRANSPOSE]], %[[C3_0]], %[[C4_1]] : !torch.vtensor<[1,2,2,2,2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[1,2,2,2,2,3],f32>
  // CHECK: %[[C4_1:.*]] = torch.constant.int 4
  // CHECK: %[[C5:.*]] = torch.constant.int 5
  // CHECK: %[[TRANSPOSE_2:.*]] = torch.aten.transpose.int %[[TRANSPOSE_1]], %[[C4_1]], %[[C5]] : !torch.vtensor<[1,2,2,2,2,3],f32>, !torch.int, !torch.int -> !torch.vtensor<[1,2,2,2,3,2],f32>
  // CHECK: %[[MUL:.*]] = torch.aten.mul.int %[[SIZE_1]], %[[C2_0]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[MUL_0:.*]] = torch.aten.mul.int %[[SIZE_2]], %[[C2_0]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[RESHAPE_LIST_0:.*]] = torch.prim.ListConstruct %[[SIZE]], %5, %[[MUL]], %[[MUL_0]] : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[RESULT:.*]] = torch.aten.reshape %[[TRANSPOSE_2]], %[[RESHAPE_LIST_0]] : !torch.vtensor<[1,2,2,2,3,2],f32>, !torch.list<int> -> !torch.vtensor<[1,2,4,6],f32>
  // CHECK: return %[[RESULT]] : !torch.vtensor<[1,2,4,6],f32
  %0 = torch.operator "onnx.DepthToSpace"(%arg0) {torch.onnx.blocksize = 2 : si64, torch.onnx.mode = "CRD"} : (!torch.vtensor<[1,8,2,3],f32>) -> !torch.vtensor<[1,2,4,6],f32>
  return %0 : !torch.vtensor<[1,2,4,6],f32>
}

