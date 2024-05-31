#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_gelu_tanh_2(%arg0: tensor<3x4x5xf32>) -> tensor<3x4x5xf32> {
    %c3_i64 = arith.constant 3 : i64
    %cst = arith.constant 4.471500e-02 : f32
    %cst_0 = arith.constant 7.977240e-01 : f32
    %cst_1 = arith.constant 1.000000e+00 : f32
    %cst_2 = arith.constant 5.000000e-01 : f32
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x4x5xf32>) outs(%0 : tensor<3x4x5xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = math.fpowi %in, %c3_i64 : f32, i64
      %3 = arith.mulf %2, %cst : f32
      %4 = arith.addf %in, %3 : f32
      %5 = arith.mulf %4, %cst_0 : f32
      %6 = math.tanh %5 : f32
      %7 = arith.addf %6, %cst_1 : f32
      %8 = arith.mulf %7, %cst_2 : f32
      %9 = arith.mulf %in, %8 : f32
      linalg.yield %9 : f32
    } -> tensor<3x4x5xf32>
    return %1 : tensor<3x4x5xf32>
  }
}

