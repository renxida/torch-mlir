

// CHECK-LABEL: @test_globalmaxpool
func.func @test_globalmaxpool(%arg0: !torch.vtensor<[1,3,5,5],f32>) -> !torch.vtensor<[1,3,1,1],f32> attributes {torch.onnx_meta.ir_version = 3 : si64, torch.onnx_meta.opset_version = 1 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %[[C0:.*]] = torch.constant.int 0
  // CHECK: %[[C1:.*]] = torch.constant.int 1
  // CHECK: %[[C5:.*]] = torch.constant.int 5
  // CHECK: %[[C5_0:.*]] = torch.constant.int 5
  // CHECK: %[[KERNELSIZE:.*]] = torch.prim.ListConstruct %[[C5]], %[[C5_0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[PADDING:.*]] = torch.prim.ListConstruct %[[C0]], %[[C0]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[DILATION:.*]] = torch.prim.ListConstruct %[[C1]], %[[C1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[STRIDE:.*]] = torch.prim.ListConstruct %[[C1]], %[[C1]] : (!torch.int, !torch.int) -> !torch.list<int>
  // CHECK: %[[FALSE:.*]] = torch.constant.bool false
  // CHECK: torch.aten.max_pool2d %arg0, %[[KERNELSIZE]], %[[STRIDE]], %[[PADDING]], %[[DILATION]], %[[FALSE]] : !torch.vtensor<[1,3,5,5],f32>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.list<int>, !torch.bool -> !torch.vtensor<[1,3,1,1],f32>
  %0 = torch.operator "onnx.GlobalMaxPool"(%arg0) : (!torch.vtensor<[1,3,5,5],f32>) -> !torch.vtensor<[1,3,1,1],f32>
  return %0 : !torch.vtensor<[1,3,1,1],f32>
}

