#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_slice_default_axes_and_slices(%arg0: tensor<20x10x5xf32>, %arg1: tensor<3xi64>, %arg2: tensor<3xi64>) -> tensor<20x10x1xf32> {
    %cst = arith.constant dense<0> : tensor<1xi64>
    %c0 = arith.constant 0 : index
    %c-1 = arith.constant -1 : index
    %c20 = arith.constant 20 : index
    %c10 = arith.constant 10 : index
    %c0_i64 = arith.constant 0 : i64
    %c20_i64 = arith.constant 20 : i64
    %c10_i64 = arith.constant 10 : i64
    %c5_i64 = arith.constant 5 : i64
    %cst_0 = arith.constant dense<1> : tensor<1xi64>
    %cst_1 = arith.constant dense<2> : tensor<1xi64>
    %0 = tensor.empty() : tensor<1xi64>
    %1 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%cst : tensor<1xi64>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %52 = arith.index_cast %in : i64 to index
      %extracted_9 = tensor.extract %arg1[%52] : tensor<3xi64>
      linalg.yield %extracted_9 : i64
    } -> tensor<1xi64>
    %extracted = tensor.extract %1[%c0] : tensor<1xi64>
    %2 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%cst : tensor<1xi64>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %52 = arith.index_cast %in : i64 to index
      %extracted_9 = tensor.extract %arg2[%52] : tensor<3xi64>
      linalg.yield %extracted_9 : i64
    } -> tensor<1xi64>
    %extracted_2 = tensor.extract %2[%c0] : tensor<1xi64>
    %3 = arith.addi %extracted, %c20_i64 : i64
    %4 = arith.cmpi sge, %extracted, %c0_i64 : i64
    %5 = arith.select %4, %extracted, %3 : i64
    %6 = arith.cmpi slt, %5, %c0_i64 : i64
    %7 = arith.select %6, %c0_i64, %5 : i64
    %8 = arith.cmpi sgt, %7, %c20_i64 : i64
    %9 = arith.select %8, %c20_i64, %7 : i64
    %10 = arith.index_cast %9 : i64 to index
    %11 = arith.index_cast %extracted_2 : i64 to index
    %12 = arith.cmpi slt, %11, %c0 : index
    %13 = arith.addi %11, %c20 : index
    %14 = arith.select %12, %13, %11 : index
    %15 = arith.cmpi slt, %14, %c0 : index
    %16 = arith.select %15, %c-1, %14 : index
    %17 = arith.cmpi sgt, %16, %c20 : index
    %18 = arith.select %17, %c20, %16 : index
    %19 = arith.subi %18, %10 : index
    %20 = arith.cmpi slt, %19, %c0 : index
    %21 = arith.select %20, %c0, %19 : index
    %extracted_slice = tensor.extract_slice %arg0[%10, 0, 0] [%21, 10, 5] [1, 1, 1] : tensor<20x10x5xf32> to tensor<?x10x5xf32>
    %cast = tensor.cast %extracted_slice : tensor<?x10x5xf32> to tensor<20x10x?xf32>
    %22 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%cst_0 : tensor<1xi64>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %52 = arith.index_cast %in : i64 to index
      %extracted_9 = tensor.extract %arg1[%52] : tensor<3xi64>
      linalg.yield %extracted_9 : i64
    } -> tensor<1xi64>
    %extracted_3 = tensor.extract %22[%c0] : tensor<1xi64>
    %23 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%cst_0 : tensor<1xi64>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %52 = arith.index_cast %in : i64 to index
      %extracted_9 = tensor.extract %arg2[%52] : tensor<3xi64>
      linalg.yield %extracted_9 : i64
    } -> tensor<1xi64>
    %extracted_4 = tensor.extract %23[%c0] : tensor<1xi64>
    %24 = arith.addi %extracted_3, %c10_i64 : i64
    %25 = arith.cmpi sge, %extracted_3, %c0_i64 : i64
    %26 = arith.select %25, %extracted_3, %24 : i64
    %27 = arith.cmpi slt, %26, %c0_i64 : i64
    %28 = arith.select %27, %c0_i64, %26 : i64
    %29 = arith.cmpi sgt, %28, %c10_i64 : i64
    %30 = arith.select %29, %c10_i64, %28 : i64
    %31 = arith.index_cast %30 : i64 to index
    %32 = arith.index_cast %extracted_4 : i64 to index
    %33 = arith.cmpi slt, %32, %c0 : index
    %34 = arith.addi %32, %c10 : index
    %35 = arith.select %33, %34, %32 : index
    %36 = arith.cmpi slt, %35, %c0 : index
    %37 = arith.select %36, %c-1, %35 : index
    %38 = arith.cmpi sgt, %37, %c10 : index
    %39 = arith.select %38, %c10, %37 : index
    %40 = arith.subi %39, %31 : index
    %41 = arith.cmpi slt, %40, %c0 : index
    %42 = arith.select %41, %c0, %40 : index
    %extracted_slice_5 = tensor.extract_slice %cast[0, %31, 0] [20, %42, 5] [1, 1, 1] : tensor<20x10x?xf32> to tensor<20x?x5xf32>
    %cast_6 = tensor.cast %extracted_slice_5 : tensor<20x?x5xf32> to tensor<20x10x?xf32>
    %43 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%cst_1 : tensor<1xi64>) outs(%0 : tensor<1xi64>) {
    ^bb0(%in: i64, %out: i64):
      %52 = arith.index_cast %in : i64 to index
      %extracted_9 = tensor.extract %arg1[%52] : tensor<3xi64>
      linalg.yield %extracted_9 : i64
    } -> tensor<1xi64>
    %extracted_7 = tensor.extract %43[%c0] : tensor<1xi64>
    %44 = arith.addi %extracted_7, %c5_i64 : i64
    %45 = arith.cmpi sge, %extracted_7, %c0_i64 : i64
    %46 = arith.select %45, %extracted_7, %44 : i64
    %47 = arith.cmpi slt, %46, %c0_i64 : i64
    %48 = arith.select %47, %c0_i64, %46 : i64
    %49 = arith.cmpi sgt, %48, %c5_i64 : i64
    %50 = arith.select %49, %c5_i64, %48 : i64
    %51 = arith.index_cast %50 : i64 to index
    %extracted_slice_8 = tensor.extract_slice %cast_6[0, 0, %51] [20, 10, 1] [1, 1, 1] : tensor<20x10x?xf32> to tensor<20x10x1xf32>
    return %extracted_slice_8 : tensor<20x10x1xf32>
  }
}

