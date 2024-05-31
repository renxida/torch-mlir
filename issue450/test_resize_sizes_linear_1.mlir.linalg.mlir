#map = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_resize_sizes_linear(%arg0: tensor<1x1x2x4xf32>, %arg1: tensor<4xi64>) -> tensor<?x?x?x?xf32> {
    %cst = arith.constant 1.000000e+00 : f32
    %cst_0 = arith.constant 5.000000e-01 : f32
    %cst_1 = arith.constant 0.000000e+00 : f32
    %cst_2 = arith.constant 2.000000e+00 : f32
    %cst_3 = arith.constant 0.998999953 : f32
    %c0 = arith.constant 0 : index
    %extracted_slice = tensor.extract_slice %arg1[2] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %extracted = tensor.extract %extracted_slice[%c0] : tensor<1xi64>
    %extracted_slice_4 = tensor.extract_slice %arg1[3] [1] [1] : tensor<4xi64> to tensor<1xi64>
    %extracted_5 = tensor.extract %extracted_slice_4[%c0] : tensor<1xi64>
    %0 = arith.index_cast %extracted : i64 to index
    %1 = arith.index_cast %extracted_5 : i64 to index
    %2 = tensor.empty(%0, %1) : tensor<1x1x?x?xf32>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} outs(%2 : tensor<1x1x?x?xf32>) {
    ^bb0(%out: f32):
      %4 = linalg.index 2 : index
      %5 = linalg.index 3 : index
      %6 = arith.sitofp %extracted : i64 to f32
      %7 = arith.divf %6, %cst_2 : f32
      %8 = arith.index_cast %4 : index to i64
      %9 = arith.sitofp %8 : i64 to f32
      %10 = arith.addf %9, %cst_0 : f32
      %11 = arith.divf %10, %7 : f32
      %12 = arith.subf %11, %cst_0 : f32
      %13 = arith.maximumf %12, %cst_1 : f32
      %14 = arith.minimumf %13, %cst_3 : f32
      %15 = arith.sitofp %extracted_5 : i64 to f32
      %16 = arith.divf %15, %cst_2 : f32
      %17 = arith.index_cast %5 : index to i64
      %18 = arith.sitofp %17 : i64 to f32
      %19 = arith.addf %18, %cst_0 : f32
      %20 = arith.divf %19, %16 : f32
      %21 = arith.subf %20, %cst_0 : f32
      %22 = arith.maximumf %21, %cst_1 : f32
      %23 = arith.minimumf %22, %cst_3 : f32
      %24 = math.floor %14 : f32
      %25 = arith.addf %14, %cst : f32
      %26 = math.floor %25 : f32
      %27 = math.floor %23 : f32
      %28 = arith.addf %23, %cst : f32
      %29 = math.floor %28 : f32
      %30 = linalg.index 0 : index
      %31 = linalg.index 1 : index
      %32 = arith.fptosi %24 : f32 to i64
      %33 = arith.index_cast %32 : i64 to index
      %34 = arith.fptosi %27 : f32 to i64
      %35 = arith.index_cast %34 : i64 to index
      %36 = arith.fptosi %26 : f32 to i64
      %37 = arith.index_cast %36 : i64 to index
      %38 = arith.fptosi %29 : f32 to i64
      %39 = arith.index_cast %38 : i64 to index
      %extracted_6 = tensor.extract %arg0[%30, %31, %33, %35] : tensor<1x1x2x4xf32>
      %extracted_7 = tensor.extract %arg0[%30, %31, %33, %39] : tensor<1x1x2x4xf32>
      %extracted_8 = tensor.extract %arg0[%30, %31, %37, %35] : tensor<1x1x2x4xf32>
      %extracted_9 = tensor.extract %arg0[%30, %31, %37, %39] : tensor<1x1x2x4xf32>
      %40 = arith.subf %29, %23 : f32
      %41 = arith.subf %29, %27 : f32
      %42 = arith.divf %40, %41 : f32
      %43 = arith.mulf %42, %extracted_6 : f32
      %44 = arith.subf %23, %27 : f32
      %45 = arith.divf %44, %41 : f32
      %46 = arith.mulf %45, %extracted_7 : f32
      %47 = arith.addf %43, %46 : f32
      %48 = arith.mulf %42, %extracted_8 : f32
      %49 = arith.mulf %45, %extracted_9 : f32
      %50 = arith.addf %48, %49 : f32
      %51 = arith.subf %26, %14 : f32
      %52 = arith.subf %26, %24 : f32
      %53 = arith.divf %51, %52 : f32
      %54 = arith.mulf %53, %47 : f32
      %55 = arith.subf %14, %24 : f32
      %56 = arith.divf %55, %52 : f32
      %57 = arith.mulf %56, %50 : f32
      %58 = arith.addf %54, %57 : f32
      linalg.yield %58 : f32
    } -> tensor<1x1x?x?xf32>
    %cast = tensor.cast %3 : tensor<1x1x?x?xf32> to tensor<?x?x?x?xf32>
    return %cast : tensor<?x?x?x?xf32>
  }
}

