

// CHECK-LABEL: func.func @test_logsoftmax_old_axis_1_dynamic_dim
  func.func @test_logsoftmax_old_axis_1_dynamic_dim(%arg0: !torch.vtensor<[3,4,?],f32>) -> !torch.vtensor<[3,4,?],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    // CHECK: %[[CI1:.*]] = torch.constant.int 1
    // CHECK: %[[NONE:.*]] = torch.constant.none
    // CHECK: %[[CI2:.*]] = torch.constant.int 2
    // CHECK: %[[CI4:.*]] = torch.constant.int 4
    // CHECK: %[[CIM1:.*]] = torch.constant.int -1
    // CHECK: %[[LIST:.*]] = torch.prim.ListConstruct %[[CI4]], %[[CIM1]] : (!torch.int, !torch.int) -> !torch.list<int>
    // CHECK: %[[FLAT_IN:.*]] = torch.aten.flatten.using_ints %arg0, %[[CI1]], %[[CI2]] : !torch.vtensor<[3,4,?],f32>, !torch.int, !torch.int -> !torch.vtensor<[3,?],f32>
    // CHECK: %[[LSM:.*]] = torch.aten.log_softmax.int %[[FLAT_IN]], %[[CI1]], %[[NONE]] : !torch.vtensor<[3,?],f32>, !torch.int, !torch.none -> !torch.vtensor<[3,?],f32>
    // CHECK: %[[UNFLAT:.*]] = torch.aten.unflatten.int %[[LSM]], %[[CI1]], %[[LIST]] : !torch.vtensor<[3,?],f32>, !torch.int, !torch.list<int> -> !torch.vtensor<[3,4,?],f32>
    // CHECK: return %[[UNFLAT]] : !torch.vtensor<[3,4,?],f32>
    %0 = torch.operator "onnx.LogSoftmax"(%arg0) {torch.onnx.axis = 1 : si64} : (!torch.vtensor<[3,4,?],f32>) -> !torch.vtensor<[3,4,?],f32>
    return %0 : !torch.vtensor<[3,4,?],f32>
  }

