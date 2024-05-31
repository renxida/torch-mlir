#map = affine_map<(d0, d1, d2) -> (d0, d1, d2)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_tril_zero(%arg0: tensor<3x0x5xi64>, %arg1: tensor<i64>) -> tensor<3x0x5xi64> {
    %c0_i64 = arith.constant 0 : i64
    %extracted = tensor.extract %arg1[] : tensor<i64>
    %0 = tensor.empty() : tensor<3x0x5xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel", "parallel"]} ins(%arg0 : tensor<3x0x5xi64>) outs(%0 : tensor<3x0x5xi64>) {
    ^bb0(%in: i64, %out: i64):
      %2 = linalg.index 1 : index
      %3 = arith.index_cast %2 : index to i64
      %4 = linalg.index 2 : index
      %5 = arith.index_cast %4 : index to i64
      %6 = arith.addi %3, %extracted : i64
      %7 = arith.cmpi sle, %5, %6 : i64
      %8 = arith.select %7, %in, %c0_i64 : i64
      linalg.yield %8 : i64
    } -> tensor<3x0x5xi64>
    return %1 : tensor<3x0x5xi64>
  }
}

