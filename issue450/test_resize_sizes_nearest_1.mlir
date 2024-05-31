

// CHECK-LABEL: func.func @test_resize_sizes_nearest
  func.func @test_resize_sizes_nearest(%arg0: !torch.vtensor<[1,1,2,4],f32>, %arg1: !torch.vtensor<[4],si64>) -> !torch.vtensor<[?,?,?,?],f32> attributes {torch.onnx_meta.ir_version = 7 : si64, torch.onnx_meta.opset_version = 19 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
    %none = torch.constant.none
    // CHECK: torch.aten.__interpolate.size_list_scale_list %arg0, %4, %none_0, %str, %false, %none_0, %false : !torch.vtensor<[1,1,2,4],f32>, !torch.list<int>, !torch.none, !torch.str, !torch.bool, !torch.none, !torch.bool -> !torch.vtensor<[?,?,?,?],f32>
    %0 = torch.operator "onnx.Resize"(%arg0, %none, %none, %arg1) {torch.onnx.coordinate_transformation_mode = "asymmetric", torch.onnx.cubic_coeff_a = -7.500000e-01 : f32, torch.onnx.mode = "nearest", torch.onnx.nearest_mode = "floor"} : (!torch.vtensor<[1,1,2,4],f32>, !torch.none, !torch.none, !torch.vtensor<[4],si64>) -> !torch.vtensor<[?,?,?,?],f32>
    return %0 : !torch.vtensor<[?,?,?,?],f32>
  }

