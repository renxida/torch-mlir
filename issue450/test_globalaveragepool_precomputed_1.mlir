

// CHECK-LABEL: @test_globalaveragepool_precomputed
func.func @test_globalaveragepool_precomputed(%arg0: !torch.vtensor<[1,1,3,3],f32>) -> !torch.vtensor<[1,1,1,1],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[C3:.*]] = torch.constant.int 3
  // CHECK: %[[C3_0:.*]] = torch.constant.int 3
  // CHECK: %[[KERNELSIZE:.*]] = torch.prim.ListConstruct %[[C3]], %[[C3_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[PADDING:.*]] = torch.prim.ListConstruct %[[C0]], %[[C0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[STRIDE:.*]] = torch.prim.ListConstruct %[[C1]], %[[C1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: %[[NONE:.*]] = torch.constant.none
  // CHECK: torch.aten.avg_pool2d %arg0, %[[KERNELSIZE]], %[[STRIDE]], %[[PADDING]], %[[FALSE]], %[[FALSE]], %[[NONE]] : !torch.vtensor<[1,1,3,3],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool, !torch.bool, !torch.none -> !torch.vtensor<[1,1,1,1],f32>
  %0 = torch.operator "onnx.GlobalAveragePool"(%arg0) : (!torch.vtensor<[1,1,3,3],f32>) -> !torch.vtensor<[1,1,1,1],f32>
  return %0 : !torch.vtensor<[1,1,1,1],f32>
}

