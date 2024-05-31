#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_resize_sizes_nearest(%arg0: tensor<1x1x2x4xf32>, %arg1: tensor<4xi64>) -> tensor<?x?x?x?xf32> {
    %cst = arith.constant 2.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %extracted_slice = tensor.extract_slice %arg1[2] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %extracted = tensor.extract %extracted_slice[%c0] : tensor<1xi64>
    %extracted_slice_0 = tensor.extract_slice %arg1[3] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %extracted_1 = tensor.extract %extracted_slice_0[%c0] : tensor<1xi64>
    %0 = arith.index_cast %extracted : i64 to index
    %1 = arith.index_cast %extracted_1 : i64 to index
    %2 = tensor.empty(%0, %1) : tensor<1x1x?x?xf32>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%2 : tensor<1x1x?x?xf32>) {
    ^bb0(%out: f32):
      %4 = linalg.index 0 : index
      %5 = linalg.index 1 : index
      %6 = linalg.index 2 : index
      %7 = linalg.index 3 : index
      %8 = arith.sitofp %extracted : i64 to f32
      %9 = arith.divf %8, %cst : f32
      %10 = arith.index_cast %6 : index to i64
      %11 = arith.sitofp %10 : i64 to f32
      %12 = arith.divf %11, %9 : f32
      %13 = math.floor %12 : f32
      %14 = arith.fptosi %13 : f32 to i64
      %15 = arith.index_cast %14 : i64 to index
      %16 = arith.sitofp %extracted_1 : i64 to f32
      %17 = arith.divf %16, %cst : f32
      %18 = arith.index_cast %7 : index to i64
      %19 = arith.sitofp %18 : i64 to f32
      %20 = arith.divf %19, %17 : f32
      %21 = math.floor %20 : f32
      %22 = arith.fptosi %21 : f32 to i64
      %23 = arith.index_cast %22 : i64 to index
      %extracted_2 = tensor.extract %arg0[%4, %5, %15, %23] : tensor<1x1x2x4xf32>
      linalg.yield %extracted_2 : f32
    } -> tensor<1x1x?x?xf32>
    %cast = tensor.cast %3 : tensor<1x1x?x?xf32> to tensor<?x?x?x?xf32>
    return %cast : tensor<?x?x?x?xf32>
  }
}

