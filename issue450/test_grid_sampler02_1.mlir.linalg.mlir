#map = affine_map<(d0, d1, d2, d3) -> (d0, d2, d3)>
#map1 = affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_grid_sampler02(%arg0: tensor<5x10x10x4xf32>, %arg1: tensor<5x7x8x2xf32>) -> tensor<?x?x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant 1.000000e+00 : f32
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c9_i64 = arith.constant 9 : i64
    %c3_i64 = arith.constant 3 : i64
    %cst_1 = arith.constant 4.500000e+00 : f32
    %cst_2 = arith.constant 1.500000e+00 : f32
    %extracted_slice = tensor.extract_slice %arg1[0, 0, 0, 0] [5, 7, 8, 1] [1, 1, 1, 2] : tensor<5x7x8x2xf32> to tensor<5x7x8x1xf32>
    %extracted_slice_3 = tensor.extract_slice %arg1[0, 0, 0, 1] [5, 7, 8, 1] [1, 1, 1, 2] : tensor<5x7x8x2xf32> to tensor<5x7x8x1xf32>
    %collapsed = tensor.collapse_shape %extracted_slice [[0], [1], [2, 3]] : tensor<5x7x8x1xf32> into tensor<5x7x8xf32>
    %collapsed_4 = tensor.collapse_shape %extracted_slice_3 [[0], [1], [2, 3]] : tensor<5x7x8x1xf32> into tensor<5x7x8xf32>
    %0 = tensor.empty() : tensor<5x10x7x8xf32>
    %1 = linalg.generic {indexing_maps = [#map, #map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel"]} ins(%collapsed, %collapsed_4 : tensor<5x7x8xf32>, tensor<5x7x8xf32>) outs(%0 : tensor<5x10x7x8xf32>) {
    ^bb0(%in: f32, %in_5: f32, %out: f32):
      %2 = arith.addf %in_5, %cst_0 : f32
      %3 = arith.addf %in, %cst_0 : f32
      %4 = arith.mulf %2, %cst_1 : f32
      %5 = arith.mulf %3, %cst_2 : f32
      %6 = arith.addf %4, %cst : f32
      %7 = arith.addf %5, %cst : f32
      %8 = arith.cmpf olt, %6, %cst : f32
      %9 = arith.cmpf olt, %7, %cst : f32
      %10 = arith.fptosi %6 : f32 to i64
      %11 = arith.fptosi %7 : f32 to i64
      %12 = arith.subi %10, %c1_i64 : i64
      %13 = arith.subi %11, %c1_i64 : i64
      %14 = arith.select %8, %12, %10 : i64
      %15 = arith.select %9, %13, %11 : i64
      %16 = arith.select %8, %c0_i64, %10 : i64
      %17 = arith.select %9, %c0_i64, %11 : i64
      %18 = arith.addi %14, %c1_i64 : i64
      %19 = arith.addi %15, %c1_i64 : i64
      %20 = arith.cmpi sgt, %18, %c9_i64 : i64
      %21 = arith.cmpi sgt, %19, %c3_i64 : i64
      %22 = arith.select %20, %14, %18 : i64
      %23 = arith.select %21, %15, %19 : i64
      %24 = arith.index_cast %16 : i64 to index
      %25 = arith.index_cast %17 : i64 to index
      %26 = arith.index_cast %22 : i64 to index
      %27 = arith.index_cast %23 : i64 to index
      %28 = linalg.index 0 : index
      %29 = linalg.index 1 : index
      %extracted = tensor.extract %arg0[%28, %29, %24, %25] : tensor<5x10x10x4xf32>
      %30 = arith.select %8, %cst, %extracted : f32
      %31 = arith.select %9, %cst, %30 : f32
      %extracted_6 = tensor.extract %arg0[%28, %29, %24, %27] : tensor<5x10x10x4xf32>
      %32 = arith.select %21, %cst, %extracted_6 : f32
      %33 = arith.select %8, %cst, %32 : f32
      %extracted_7 = tensor.extract %arg0[%28, %29, %26, %25] : tensor<5x10x10x4xf32>
      %34 = arith.select %20, %cst, %extracted_7 : f32
      %35 = arith.select %9, %cst, %34 : f32
      %extracted_8 = tensor.extract %arg0[%28, %29, %26, %27] : tensor<5x10x10x4xf32>
      %36 = arith.select %20, %cst, %extracted_8 : f32
      %37 = arith.select %21, %cst, %36 : f32
      %38 = arith.sitofp %14 : i64 to f32
      %39 = arith.sitofp %15 : i64 to f32
      %40 = arith.subf %6, %38 : f32
      %41 = arith.subf %7, %39 : f32
      %42 = arith.subf %cst_0, %41 : f32
      %43 = arith.mulf %31, %42 : f32
      %44 = arith.mulf %33, %41 : f32
      %45 = arith.addf %43, %44 : f32
      %46 = arith.mulf %35, %42 : f32
      %47 = arith.mulf %37, %41 : f32
      %48 = arith.addf %46, %47 : f32
      %49 = arith.subf %cst_0, %40 : f32
      %50 = arith.mulf %45, %49 : f32
      %51 = arith.mulf %48, %40 : f32
      %52 = arith.addf %50, %51 : f32
      linalg.yield %52 : f32
    } -> tensor<5x10x7x8xf32>
    %cast = tensor.cast %1 : tensor<5x10x7x8xf32> to tensor<?x?x?x?xf32>
    return %cast : tensor<?x?x?x?xf32>
  }
}

