#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_range_int16_type(%arg0: tensor<i16>, %arg1: tensor<i16>, %arg2: tensor<i16>) -> tensor<2xi16> {
    %extracted = tensor.extract %arg0[] : tensor<i16>
    %extracted_0 = tensor.extract %arg2[] : tensor<i16>
    %0 = tensor.empty() : tensor<2xi16>
    %1 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%0 : tensor<2xi16>) {
    ^bb0(%out: i16):
      %2 = linalg.index 0 : index
      %3 = arith.index_cast %2 : index to i64
      %4 = arith.trunci %3 : i64 to i16
      %5 = arith.muli %extracted_0, %4 : i16
      %6 = arith.addi %extracted, %5 : i16
      linalg.yield %6 : i16
    } -> tensor<2xi16>
    return %1 : tensor<2xi16>
  }
}

