

// CHECK-LABEL: @test_qlinearmatmul_2D
func.func @test_qlinearmatmul_2D(%arg0: !torch.vtensor<[2,4],ui8>, %arg1: !torch.vtensor<[1],f32>, %arg2: !torch.vtensor<[1],ui8>, %arg3: !torch.vtensor<[4,3],ui8>, %arg4: !torch.vtensor<[1],f32>, %arg5: !torch.vtensor<[1],ui8>, %arg6: !torch.vtensor<[1],f32>, %arg7: !torch.vtensor<[1],ui8>) -> !torch.vtensor<[2,3],ui8> attributes {torch.onnx_meta.ir_version = 5 : si64, torch.onnx_meta.opset_version = 10 : si64, torch.onnx_meta.producer_name = "backend-test", torch.onnx_meta.producer_version = ""} {
  %0 = torch.operator "onnx.QLinearMatMul"(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %arg6, %arg7) : (!torch.vtensor<[2,4],ui8>, !torch.vtensor<[1],f32>, !torch.vtensor<[1],ui8>, !torch.vtensor<[4,3],ui8>, !torch.vtensor<[1],f32>, !torch.vtensor<[1],ui8>, !torch.vtensor<[1],f32>, !torch.vtensor<[1],ui8>) -> !torch.vtensor<[2,3],ui8>
  // CHECK-DAG: %[[EMPTY:.+]] = torch.prim.ListConstruct  : () -> !torch.list<int>
  // CHECK-DAG: %[[RESH0:.+]] = torch.aten.reshape %arg2, %[[EMPTY]] : !torch.vtensor<[1],ui8>, !torch.list<int> -> !torch.vtensor<[],ui8>
  // CHECK-DAG: %[[RESH1:.+]] = torch.aten.reshape %arg5, %[[EMPTY]] : !torch.vtensor<[1],ui8>, !torch.list<int> -> !torch.vtensor<[],ui8>
  // CHECK-DAG: %[[RESH2:.+]] = torch.aten.reshape %arg7, %[[EMPTY]] : !torch.vtensor<[1],ui8>, !torch.list<int> -> !torch.vtensor<[],ui8>
  // CHECK-DAG: %[[RESH3:.+]] = torch.aten.reshape %arg1, %[[EMPTY]] : !torch.vtensor<[1],f32>, !torch.list<int> -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[RESH4:.+]] = torch.aten.reshape %arg4, %[[EMPTY]] : !torch.vtensor<[1],f32>, !torch.list<int> -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[RESH5:.+]] = torch.aten.reshape %arg6, %[[EMPTY]] : !torch.vtensor<[1],f32>, !torch.list<int> -> !torch.vtensor<[],f32>
  // CHECK-DAG: %[[AZP:.+]] = torch.aten.item %[[RESH0]] : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK-DAG: %[[BZP:.+]] = torch.aten.item %[[RESH1]] : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK-DAG: %[[CZP:.+]] = torch.aten.item %[[RESH2]] : !torch.vtensor<[],ui8> -> !torch.int
  // CHECK-DAG: %[[ASCALE:.+]] = torch.aten.item %[[RESH3]] : !torch.vtensor<[],f32> -> !torch.float
  // CHECK-DAG: %[[BSCALE:.+]] = torch.aten.item %[[RESH4]] : !torch.vtensor<[],f32> -> !torch.float
  // CHECK-DAG: %[[CCSCALE:.+]] = torch.aten.item %[[RESH5]] : !torch.vtensor<[],f32> -> !torch.float
  // CHECK-DAG: %[[LHS:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg0, %[[ASCALE]], %[[AZP]] : !torch.vtensor<[2,4],ui8>, !torch.float, !torch.int -> !torch.vtensor<[2,4],!torch.quint8>
  // CHECK-DAG: %[[RHS:.+]] = torch.aten._make_per_tensor_quantized_tensor %arg3, %[[BSCALE]], %[[BZP]] : !torch.vtensor<[4,3],ui8>, !torch.float, !torch.int -> !torch.vtensor<[4,3],!torch.quint8>
  // CHECK: %[[MM:.+]] = torch.aten.mm %[[LHS]], %[[RHS]] : !torch.vtensor<[2,4],!torch.quint8>, !torch.vtensor<[4,3],!torch.quint8> -> !torch.vtensor<[2,3],si32>
  // CHECK: %[[CSCALE:.+]] = torch.aten.mul.float %[[ASCALE]], %[[BSCALE]] : !torch.float, !torch.float -> !torch.float
  // CHECK: %[[ZERO:.+]] = torch.constant.int 0
  // CHECK: %[[QC:.+]] = torch.aten._make_per_tensor_quantized_tensor %[[MM]], %[[CSCALE]], %[[ZERO]] : !torch.vtensor<[2,3],si32>, !torch.float, !torch.int -> !torch.vtensor<[2,3],!torch.qint32>
  // CHECK: %[[FC:.+]] = torch.aten.dequantize.self %[[QC]] : !torch.vtensor<[2,3],!torch.qint32> -> !torch.vtensor<[2,3],f32>
  // CHECK: %[[DTY:.+]] = torch.constant.int 13
  // CHECK: %[[QO:.+]] = torch.aten.quantize_per_tensor %[[FC]], %[[CCSCALE]], %[[CZP]], %[[DTY]] : !torch.vtensor<[2,3],f32>, !torch.float, !torch.int, !torch.int -> !torch.vtensor<[2,3],!torch.quint8>
  // CHECK: %[[OUT:.+]] = torch.aten.int_repr %[[QO]] : !torch.vtensor<[2,3],!torch.quint8> -> !torch.vtensor<[2,3],ui8>
  // CHECK: return %[[OUT]]
  return %0 : !torch.vtensor<[2,3],ui8>
}

