#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_sigmoid_example(%arg0: tensor<3xf32>) -> tensor<3xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %0 = tensor.empty() : tensor<3xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%arg0 : tensor<3xf32>) outs(%0 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %2 = arith.negf %in : f32
      %3 = math.exp %2 : f32
      %4 = arith.addf %3, %cst : f32
      %5 = arith.divf %cst, %4 : f32
      linalg.yield %5 : f32
    } -> tensor<3xf32>
    return %1 : tensor<3xf32>
  }
}

