#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_quantizelinear_ui8(%arg0: tensor<6xf32>, %arg1: tensor<f32>, %arg2: tensor<i8>) -> tensor<6xi8> {
    %cst = arith.constant 2.550000e+02 : f32
    %cst_0 = arith.constant 0.000000e+00 : f32
    %extracted = tensor.extract %arg1[] : tensor<f32>
    %0 = arith.extf %extracted : f32 to f64
    %extracted_1 = tensor.extract %arg2[] : tensor<i8>
    %1 = arith.extui %extracted_1 : i8 to i64
    %2 = tensor.empty() : tensor<6xi8>
    %3 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<6xf32>) outs(%2 : tensor<6xi8>) {
    ^bb0(%in: f32, %out: i8):
      %4 = arith.sitofp %1 : i64 to f32
      %5 = arith.truncf %0 : f64 to f32
      %6 = arith.divf %in, %5 : f32
      %7 = math.round %6 : f32
      %8 = arith.addf %7, %4 : f32
      %9 = arith.cmpf ult, %8, %cst_0 : f32
      %10 = arith.cmpf ugt, %8, %cst : f32
      %11 = arith.select %9, %cst_0, %8 : f32
      %12 = arith.select %10, %cst, %11 : f32
      %13 = arith.fptoui %12 : f32 to i8
      linalg.yield %13 : i8
    } -> tensor<6xi8>
    return %3 : tensor<6xi8>
  }
}

