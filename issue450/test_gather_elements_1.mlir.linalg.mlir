#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_gather_elements(%arg0: tensor<3x4x5xf32>, %arg1: tensor<3x4x5xi64>) -> tensor<3x4x5xf32> {
    %c3 = arith.constant 3 : index
    %cst = arith.constant 0.000000e+00 : f32
    %c0_i64 = arith.constant 0 : i64
    %0 = tensor.empty() : tensor<3x4x5xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3x4x5xf32>) -> tensor<3x4x5xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg1 : tensor<3x4x5xi64>) outs(%1 : tensor<3x4x5xf32>) {
    ^bb0(%in: i64, %out: f32):
      %3 = arith.index_cast %in : i64 to index
      %4 = linalg.index 1 : index
      %5 = linalg.index 2 : index
      %6 = arith.cmpi slt, %3, %c3 : index
      cf.assert %6, "index must be smaller than dim size"
      %7 = arith.cmpi sge, %in, %c0_i64 : i64
      cf.assert %7, "index must be larger or equal to 0"
      %extracted = tensor.extract %arg0[%3, %4, %5] : tensor<3x4x5xf32>
      linalg.yield %extracted : f32
    } -> tensor<3x4x5xf32>
    return %2 : tensor<3x4x5xf32>
  }
}

