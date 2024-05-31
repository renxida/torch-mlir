#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_dequantizelinear_si8(%arg0: tensor<6xi8>, %arg1: tensor<f32>, %arg2: tensor<i8>) -> tensor<6xf32> {
    %extracted = tensor.extract %arg1[] : tensor<f32>
    %0 = arith.extf %extracted : f32 to f64
    %extracted_0 = tensor.extract %arg2[] : tensor<i8>
    %1 = tensor.empty() : tensor<6xf32>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xi8>) outs(%1 : tensor<6xf32>) {
    ^bb0(%in: i8, %out: f32):
      %3 = arith.extsi %in : i8 to i32
      %4 = arith.extsi %extracted_0 : i8 to i32
      %5 = arith.subi %3, %4 : i32
      %6 = arith.sitofp %5 : i32 to f32
      %7 = arith.truncf %0 : f64 to f32
      %8 = arith.mulf %6, %7 : f32
      linalg.yield %8 : f32
    } -> tensor<6xf32>
    return %2 : tensor<6xf32>
  }
}

