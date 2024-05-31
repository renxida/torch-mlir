#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_range_float64_type(%arg0: tensor<f64>, %arg1: tensor<f64>, %arg2: tensor<f64>) -> tensor<2xf64> {
    %extracted = tensor.extract %arg0[] : tensor<f64>
    %extracted_0 = tensor.extract %arg2[] : tensor<f64>
    %0 = tensor.empty() : tensor<2xf64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<2xf64>) {
    ^bb0(%out: f64):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %2 : index to i64
      %4 = arith.sitofp %3 : i64 to f64
      %5 = arith.mulf %extracted_0, %4 : f64
      %6 = arith.addf %extracted, %5 : f64
      linalg.yield %6 : f64
    } -> tensor<2xf64>
    return %1 : tensor<2xf64>
  }
}

