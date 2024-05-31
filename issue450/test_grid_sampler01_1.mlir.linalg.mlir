#map = affine_map<(d0, d1, d2, d3) -> (d0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_grid_sampler01(%arg0: tensor<5x10x10x4xf32>, %arg1: tensor<5x7x8x2xf32>) -> tensor<?x?x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %cst_1 = arith.constant 2.000000e+00 : f32
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c9_i64 = arith.constant 9 : i64
    %c3_i64 = arith.constant 3 : i64
    %cst_2 = arith.constant 4.500000e+00 : f32
    %cst_3 = arith.constant 1.500000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg1[0, 0, 0, 0] [5, 7, 8, 1] [1, 1, 1, 2] : tensor<5x7x8x2xf32> to tensor<5x7x8x1xf32>
    %extracted_slice_4 = tensor.extract_slice %arg1[0, 0, 0, 1] [5, 7, 8, 1] [1, 1, 1, 2] : tensor<5x7x8x2xf32> to tensor<5x7x8x1xf32>
    %collapsed = tensor.collapse_shape %extracted_slice [[0], [1], [2, 3]] : tensor<5x7x8x1xf32> into tensor<5x7x8xf32>
    %collapsed_5 = tensor.collapse_shape %extracted_slice_4 [[0], [1], [2, 3]] : tensor<5x7x8x1xf32> into tensor<5x7x8xf32>
    %0 = tensor.empty() : tensor<5x10x7x8xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%collapsed, %collapsed_5 : tensor<5x7x8xf32>, tensor<5x7x8xf32>) outs(%0 : tensor<5x10x7x8xf32>) {
    ^bb0(%in: f32, %in_6: f32, %out: f32):
      %2 = arith.divf %in_6, %cst_1 : f32
      %3 = arith.divf %in, %cst_1 : f32
      %4 = arith.addf %in_6, %cst_0 : f32
      %5 = arith.addf %in, %cst_0 : f32
      %6 = arith.mulf %4, %cst_2 : f32
      %7 = arith.mulf %5, %cst_3 : f32
      %8 = arith.addf %6, %2 : f32
      %9 = arith.addf %7, %3 : f32
      %10 = arith.cmpf olt, %8, %cst : f32
      %11 = arith.cmpf olt, %9, %cst : f32
      %12 = arith.fptosi %8 : f32 to i64
      %13 = arith.fptosi %9 : f32 to i64
      %14 = arith.subi %12, %c1_i64 : i64
      %15 = arith.subi %13, %c1_i64 : i64
      %16 = arith.select %10, %14, %12 : i64
      %17 = arith.select %11, %15, %13 : i64
      %18 = arith.select %10, %c0_i64, %12 : i64
      %19 = arith.select %11, %c0_i64, %13 : i64
      %20 = arith.addi %16, %c1_i64 : i64
      %21 = arith.addi %17, %c1_i64 : i64
      %22 = arith.cmpi sgt, %20, %c9_i64 : i64
      %23 = arith.cmpi sgt, %21, %c3_i64 : i64
      %24 = arith.select %22, %16, %20 : i64
      %25 = arith.select %23, %17, %21 : i64
      %26 = arith.index_cast %18 : i64 to index
      %27 = arith.index_cast %19 : i64 to index
      %28 = arith.index_cast %24 : i64 to index
      %29 = arith.index_cast %25 : i64 to index
      %30 = linalg.index 0 : index
      %31 = linalg.index 1 : index
      %extracted = tensor.extract %arg0[%30, %31, %26, %27] : tensor<5x10x10x4xf32>
      %32 = arith.select %10, %cst, %extracted : f32
      %33 = arith.select %11, %cst, %32 : f32
      %extracted_7 = tensor.extract %arg0[%30, %31, %26, %29] : tensor<5x10x10x4xf32>
      %34 = arith.select %23, %cst, %extracted_7 : f32
      %35 = arith.select %10, %cst, %34 : f32
      %extracted_8 = tensor.extract %arg0[%30, %31, %28, %27] : tensor<5x10x10x4xf32>
      %36 = arith.select %22, %cst, %extracted_8 : f32
      %37 = arith.select %11, %cst, %36 : f32
      %extracted_9 = tensor.extract %arg0[%30, %31, %28, %29] : tensor<5x10x10x4xf32>
      %38 = arith.select %22, %cst, %extracted_9 : f32
      %39 = arith.select %23, %cst, %38 : f32
      %40 = arith.sitofp %16 : i64 to f32
      %41 = arith.sitofp %17 : i64 to f32
      %42 = arith.subf %8, %40 : f32
      %43 = arith.subf %9, %41 : f32
      %44 = arith.subf %cst_0, %43 : f32
      %45 = arith.mulf %33, %44 : f32
      %46 = arith.mulf %35, %43 : f32
      %47 = arith.addf %45, %46 : f32
      %48 = arith.mulf %37, %44 : f32
      %49 = arith.mulf %39, %43 : f32
      %50 = arith.addf %48, %49 : f32
      %51 = arith.subf %cst_0, %42 : f32
      %52 = arith.mulf %47, %51 : f32
      %53 = arith.mulf %50, %42 : f32
      %54 = arith.addf %52, %53 : f32
      linalg.yield %54 : f32
    } -> tensor<5x10x7x8xf32>
    %cast = tensor.cast %1 : tensor<5x10x7x8xf32> to tensor<?x?x?x?xf32>
    return %cast : tensor<?x?x?x?xf32>
  }
}

