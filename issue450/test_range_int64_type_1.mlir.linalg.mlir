#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_range_int64_type(%arg0: tensor<i64>, %arg1: tensor<i64>, %arg2: tensor<i64>) -> tensor<2xi64> {
    %extracted = tensor.extract %arg0[] : tensor<i64>
    %extracted_0 = tensor.extract %arg2[] : tensor<i64>
    %0 = tensor.empty() : tensor<2xi64>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<2xi64>) {
    ^bb0(%out: i64):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %2 : index to i64
      %4 = arith.muli %extracted_0, %3 : i64
      %5 = arith.addi %extracted, %4 : i64
      linalg.yield %5 : i64
    } -> tensor<2xi64>
    return %1 : tensor<2xi64>
  }
}

