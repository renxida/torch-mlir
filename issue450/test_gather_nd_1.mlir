

// CHECK-LABEL: func.func @test_gather_nd
func.func @test_gather_nd(%arg0: !torch.vtensor<[2,6,8,5],f32>, %arg1: !torch.vtensor<[2,4,3,2], si64>) -> !torch.vtensor<[2,4,3,5],f32> attributes {torch.onnx_meta.opset_version = 13 : si64} {
  // CHECK: %[[INT0:.+]] = torch.constant.int 0
  // CHECK: %[[SIZE0:.+]] = torch.aten.size.int %arg0, %[[INT0]] : !torch.vtensor<[2,6,8,5],f32>, !torch.int -> !torch.int
  // CHECK: %[[INT1:.+]] = torch.constant.int 1
  // CHECK: %[[SIZE1:.+]] = torch.aten.size.int %arg0, %[[INT1]] : !torch.vtensor<[2,6,8,5],f32>, !torch.int -> !torch.int
  // CHECK: %[[INT2:.+]] = torch.constant.int 2
  // CHECK: %[[SIZE2:.+]] = torch.aten.size.int %arg0, %[[INT2]] : !torch.vtensor<[2,6,8,5],f32>, !torch.int -> !torch.int
  // CHECK: %[[INT3:.+]] = torch.constant.int 3
  // CHECK: %[[SIZE3:.+]] = torch.aten.size.int %arg0, %[[INT3]] : !torch.vtensor<[2,6,8,5],f32>, !torch.int -> !torch.int
  // CHECK: %[[INT0_3:.+]] = torch.constant.int 0
  // CHECK: %[[INT1_4:.+]] = torch.constant.int 1
  // CHECK: %[[INT0_0:.+]] = torch.constant.int 0
  // CHECK: %[[INDSIZE0:.+]] = torch.aten.size.int %arg1, %[[INT0_0]] : !torch.vtensor<[2,4,3,2],si64>, !torch.int -> !torch.int
  // CHECK: %[[INT1_1:.+]] = torch.constant.int 1
  // CHECK: %[[INDSIZE1:.+]] = torch.aten.size.int %arg1, %[[INT1_1]] : !torch.vtensor<[2,4,3,2],si64>, !torch.int -> !torch.int
  // CHECK: %[[MUL1:.+]] = torch.aten.mul.int %[[INT1_4]], %[[INDSIZE1]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[INT2_2:.+]] = torch.constant.int 2
  // CHECK: %[[INDSIZE2:.+]] = torch.aten.size.int %arg1, %[[INT2_2]] : !torch.vtensor<[2,4,3,2],si64>, !torch.int -> !torch.int
  // CHECK: %[[MUL2:.+]] = torch.aten.mul.int %[[MUL1]], %[[INDSIZE2]] : !torch.int, !torch.int -> !torch.int
  // CHECK: %[[INT3_5:.+]] = torch.constant.int 3
  // CHECK: %[[INT1_6:.+]] = torch.constant.int 1
  // CHECK: %[[SLICE0:.+]] = torch.aten.slice.Tensor %arg1, %[[INT3_5]], %[[INT0_3]], %[[INT1_6]], %[[INT1_4]] : !torch.vtensor<[2,4,3,2],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[LT0:.+]] = torch.aten.lt.Scalar %[[SLICE0]], %[[INT0_3]] : !torch.vtensor<[2,4,3,1],si64>, !torch.int -> !torch.vtensor<[2,4,3,1],i1>
  // CHECK: %[[ADD0:.+]] = torch.aten.add.Scalar %[[SLICE0]], %[[SIZE1]], %[[INT1_4]] : !torch.vtensor<[2,4,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[WHERE0:.+]] = torch.aten.where.self %[[LT0]], %[[ADD0]], %[[SLICE0]] : !torch.vtensor<[2,4,3,1],i1>, !torch.vtensor<[2,4,3,1],si64>, !torch.vtensor<[2,4,3,1],si64> -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[INT2_7:.+]] = torch.constant.int 2
  // CHECK: %[[SLICE1:.+]] = torch.aten.slice.Tensor %arg1, %[[INT3_5]], %[[INT1_6]], %[[INT2_7]], %[[INT1_4]] : !torch.vtensor<[2,4,3,2],si64>, !torch.int, !torch.int, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[LT1:.+]] = torch.aten.lt.Scalar %[[SLICE1]], %[[INT0_3]] : !torch.vtensor<[2,4,3,1],si64>, !torch.int -> !torch.vtensor<[2,4,3,1],i1>
  // CHECK: %[[ADD1:.+]] = torch.aten.add.Scalar %[[SLICE1]], %[[SIZE2]], %[[INT1_4]] : !torch.vtensor<[2,4,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[WHERE1:.+]] = torch.aten.where.self %[[LT1]], %[[ADD1]], %[[SLICE1]] : !torch.vtensor<[2,4,3,1],i1>, !torch.vtensor<[2,4,3,1],si64>, !torch.vtensor<[2,4,3,1],si64> -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[NEWIND:.+]] = torch.aten.add.Tensor %[[WHERE1]], %[[WHERE0]], %[[SIZE2]] : !torch.vtensor<[2,4,3,1],si64>, !torch.vtensor<[2,4,3,1],si64>, !torch.int -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[LIST0:.+]] = torch.prim.ListConstruct %[[INDSIZE0]], %[[INDSIZE1]], %[[INDSIZE2]], %[[INT1_4]] : (!torch.int, !torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[VIEW:.+]] = torch.aten.view %[[NEWIND]], %[[LIST0]] : !torch.vtensor<[2,4,3,1],si64>, !torch.list<int> -> !torch.vtensor<[2,4,3,1],si64>
  // CHECK: %[[INT1_8:.+]] = torch.constant.int 1
  // CHECK: %[[INT2_9:.+]] = torch.constant.int 2
  // CHECK: %[[FLATIND:.+]] = torch.aten.flatten.using_ints %[[VIEW]], %[[INT1_8]], %[[INT2_9]] : !torch.vtensor<[2,4,3,1],si64>, !torch.int, !torch.int -> !torch.vtensor<[2,12,1],si64>
  // CHECK: %[[EXLIST:.+]] = torch.prim.ListConstruct %[[SIZE0]], %[[MUL2]], %[[SIZE3]] : (!torch.int, !torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.+]] = torch.constant.bool false
  // CHECK: %[[EXPANDIND:.+]] = torch.aten.expand %[[FLATIND]], %[[EXLIST]], %[[FALSE]] : !torch.vtensor<[2,12,1],si64>, !torch.list<int>, !torch.bool -> !torch.vtensor<[2,12,5],si64>
  // CHECK: %[[INT2_10:.+]] = torch.constant.int 2
  // CHECK: %[[FLATDATA:.+]] = torch.aten.flatten.using_ints %arg0, %[[INT1_8]], %[[INT2_10]] : !torch.vtensor<[2,6,8,5],f32>, !torch.int, !torch.int -> !torch.vtensor<[2,48,5],f32>
  // CHECK: %[[GATHER:.+]] = torch.aten.gather %[[FLATDATA]], %[[INT1_8]], %[[EXPANDIND]], %[[FALSE]]
  // CHECK: %[[LIST1:.+]] = torch.prim.ListConstruct %[[INDSIZE1]], %[[INDSIZE2]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[UNFLAT:.+]] = torch.aten.unflatten.int %[[GATHER]], %[[INT1_8]], %[[LIST1]] : !torch.vtensor<[2,12,5],f32>, !torch.int, !torch.list<int> -> !torch.vtensor<[2,4,3,5],f32>
  // CHECK: return %[[UNFLAT]] : !torch.vtensor<[2,4,3,5],f32>
  %0 = torch.operator "onnx.GatherND"(%arg0, %arg1) {torch.onnx.batch_dims = 1 : si64} : (!torch.vtensor<[2,6,8,5],f32>, !torch.vtensor<[2,4,3,2], si64>) -> !torch.vtensor<[2,4,3,5],f32>
  return %0 : !torch.vtensor<[2,4,3,5],f32>
}

