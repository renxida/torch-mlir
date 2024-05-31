

// CHECK-LABEL : func.func @test_layer_norm_single_result
func.func @test_layer_norm_single_result(%arg0: !torch.vtensor<[1,4,768],f32>, %arg1: !torch.vtensor<[768],f32>, %arg2: !torch.vtensor<[768],f32>) -> (!torch.vtensor<[1,4,768], f32>)
                           attributes {torch.onnx_meta.ir_version = 6 : si64, torch.onnx_meta.opset_version = 17 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  // CHECK: %float9.999990e-06 = torch.constant.float 9.9999997473787516E-6
  // CHECK: %int768 = torch.constant.int 768
  // CHECK: %0 = torch.prim.ListConstruct %int768 : (!torch.int) -> !torch.list<int>
  // CHECK: %result0, %result1, %result2 = torch.aten.native_layer_norm %arg0, %0, %arg1, %arg2
  %0 = torch.operator "onnx.LayerNormalization"(%arg0, %arg1, %arg2) {torch.onnx.axis = -1 : si64, torch.onnx.epsilon = 9.99999974E-6 : f32} : (!torch.vtensor<[1,4,768],f32>, !torch.vtensor<[768],f32>, !torch.vtensor<[768],f32>) -> !torch.vtensor<[1,4,768],f32>
  return %0 : !torch.vtensor<[1,4,768],f32>
}

