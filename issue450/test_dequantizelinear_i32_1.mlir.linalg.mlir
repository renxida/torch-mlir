#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_dequantizelinear_i32(%arg0: tensor<6xi32>, %arg1: tensor<f32>, %arg2: tensor<i32>) -> tensor<6xf32> {
    %extracted = tensor.extract %arg1[] : tensor<f32>
    %0 = arith.extf %extracted : f32 to f64
    %extracted_0 = tensor.extract %arg2[] : tensor<i32>
    %1 = tensor.empty() : tensor<6xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xi32>) outs(%1 : tensor<6xf32>) {
    ^bb0(%in: i32, %out: f32):
      %3 = arith.subi %in, %extracted_0 : i32
      %4 = arith.sitofp %3 : i32 to f32
      %5 = arith.truncf %0 : f64 to f32
      %6 = arith.mulf %4, %5 : f32
      linalg.yield %6 : f32
    } -> tensor<6xf32>
    return %2 : tensor<6xf32>
  }
}

