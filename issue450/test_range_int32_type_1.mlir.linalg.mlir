#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_range_int32_type(%arg0: tensor<i32>, %arg1: tensor<i32>, %arg2: tensor<i32>) -> tensor<2xi32> {
    %extracted = tensor.extract %arg0[] : tensor<i32>
    %extracted_0 = tensor.extract %arg2[] : tensor<i32>
    %0 = tensor.empty() : tensor<2xi32>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<2xi32>) {
    ^bb0(%out: i32):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %2 : index to i64
      %4 = arith.trunci %3 : i64 to i32
      %5 = arith.muli %extracted_0, %4 : i32
      %6 = arith.addi %extracted, %5 : i32
      linalg.yield %6 : i32
    } -> tensor<2xi32>
    return %1 : tensor<2xi32>
  }
}

