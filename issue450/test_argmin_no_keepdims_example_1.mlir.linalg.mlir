#map = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<(d0, d1) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_argmin_no_keepdims_example(%arg0: tensor<2x2xf32>) -> tensor<2xi64> {
    %c0_i64 = arith.constant 0 : i64
    %cst = arith.constant 0x7F800000 : f32
    %0 = tensor.empty() : tensor<2xi64>
    %1 = linalg.fill ins(%c0_i64 : i64) outs(%0 : tensor<2xi64>) -> tensor<2xi64>
    %2 = tensor.empty() : tensor<2xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<2xf32>) -> tensor<2xf32>
    %4:2 = linalg.generic {indexing_maps = [#map, #map1, #map1], iterator_types = ["parallel", "reduction"]} ins(%arg0 : tensor<2x2xf32>) outs(%3, %1 : tensor<2xf32>, tensor<2xi64>) {
    ^bb0(%in: f32, %out: f32, %out_0: i64):
      %5 = linalg.index 1 : index
      %6 = arith.index_cast %5 : index to i64
      %7 = arith.minimumf %in, %out : f32
      %8 = arith.cmpf olt, %in, %out : f32
      %9 = arith.select %8, %6, %out_0 : i64
      linalg.yield %7, %9 : f32, i64
    } -> (tensor<2xf32>, tensor<2xi64>)
    return %4#1 : tensor<2xi64>
  }
}

