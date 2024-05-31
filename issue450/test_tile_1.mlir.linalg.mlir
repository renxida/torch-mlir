#map = affine_map<(d0, d1, d2, d3, d4, d5) -> (0, d1, 0, d3, 0, d5)>
#map1 = affine_map<(d0, d1, d2, d3, d4, d5) -> (d0, d1, d2, d3, d4, d5)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_tile(%arg0: tensor<2x3x4xf32>, %arg1: tensor<3xi64>) -> tensor<2x12x4xf32> {
    %c1 = arith.constant 1 : index
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c2_i64 = arith.constant 2 : i64
    %c3_i64 = arith.constant 3 : i64
    %c4_i64 = arith.constant 4 : i64
    %c0 = arith.constant 0 : index
    %extracted_slice = tensor.extract_slice %arg1[0] [1] [1] : tensor<3xi64> to tensor<1xi64>
    %extracted = tensor.extract %extracted_slice[%c0] : tensor<1xi64>
    %extracted_slice_0 = tensor.extract_slice %arg1[1] [1] [1] : tensor<3xi64> to tensor<1xi64>
    %extracted_1 = tensor.extract %extracted_slice_0[%c0] : tensor<1xi64>
    %extracted_slice_2 = tensor.extract_slice %arg1[2] [1] [1] : tensor<3xi64> to tensor<1xi64>
    %extracted_3 = tensor.extract %extracted_slice_2[%c0] : tensor<1xi64>
    %expanded = tensor.expand_shape %arg0 [[0, 1], [2, 3], [4, 5]] output_shape [1, 2, 1, 3, 1, 4] : tensor<2x3x4xf32> into tensor<1x2x1x3x1x4xf32>
    %0 = arith.cmpi slt, %extracted, %c0_i64 : i64
    %1 = arith.index_cast %extracted : i64 to index
    %2 = arith.select %0, %c1, %1 : index
    %3 = arith.cmpi slt, %extracted_1, %c0_i64 : i64
    %4 = arith.index_cast %extracted_1 : i64 to index
    %5 = arith.select %3, %c1, %4 : index
    %6 = arith.cmpi slt, %extracted_3, %c0_i64 : i64
    %7 = arith.index_cast %extracted_3 : i64 to index
    %8 = arith.select %6, %c1, %7 : index
    %9 = tensor.empty(%2, %5, %8) : tensor<?x2x?x3x?x4xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map1], iterator_types = ["parallel", "parallel", "parallel", "parallel", "parallel", "parallel"]} ins(%expanded : tensor<1x2x1x3x1x4xf32>) outs(%9 : tensor<?x2x?x3x?x4xf32>) {
    ^bb0(%in: f32, %out: f32):
      linalg.yield %in : f32
    } -> tensor<?x2x?x3x?x4xf32>
    %11 = arith.index_cast %5 : index to i64
    %12 = arith.index_cast %8 : index to i64
    %13 = arith.cmpi slt, %11, %c0_i64 : i64
    %14 = arith.select %13, %c1_i64, %11 : i64
    %15 = arith.select %13, %c2_i64, %c1_i64 : i64
    %16 = arith.muli %14, %c3_i64 : i64
    %17 = arith.muli %16, %12 : i64
    %18 = arith.addi %15, %c1_i64 : i64
    %19 = arith.cmpi slt, %12, %c0_i64 : i64
    %20 = arith.select %19, %16, %17 : i64
    %21 = arith.select %19, %18, %15 : i64
    %22 = arith.muli %20, %c4_i64 : i64
    %23 = arith.cmpi sle, %21, %c1_i64 : i64
    cf.assert %23, "must have at most one inferred (negative) dimension"
    %24 = arith.index_cast %2 : index to i64
    %25 = arith.muli %24, %c2_i64 : i64
    %26 = arith.muli %25, %11 : i64
    %27 = arith.muli %26, %c3_i64 : i64
    %28 = arith.muli %27, %12 : i64
    %29 = arith.muli %28, %c4_i64 : i64
    %30 = arith.divsi %29, %22 : i64
    %31 = arith.select %13, %30, %11 : i64
    %32 = arith.select %19, %30, %12 : i64
    %from_elements = tensor.from_elements %30, %31, %c3_i64, %32, %c4_i64 : tensor<5xi64>
    %reshape = tensor.reshape %10(%from_elements) : (tensor<?x2x?x3x?x4xf32>, tensor<5xi64>) -> tensor<?x?x3x?x4xf32>
    %33 = arith.cmpi slt, %30, %c0_i64 : i64
    %34 = arith.select %33, %c1_i64, %30 : i64
    %35 = arith.extui %33 : i1 to i64
    %36 = arith.addi %35, %c1_i64 : i64
    %37 = arith.muli %34, %32 : i64
    %38 = arith.addi %35, %c2_i64 : i64
    %39 = arith.cmpi slt, %32, %c0_i64 : i64
    %40 = arith.select %39, %34, %37 : i64
    %41 = arith.select %39, %38, %36 : i64
    %42 = arith.muli %40, %c4_i64 : i64
    %43 = arith.cmpi sle, %41, %c1_i64 : i64
    cf.assert %43, "must have at most one inferred (negative) dimension"
    %44 = arith.muli %30, %31 : i64
    %45 = arith.muli %44, %c3_i64 : i64
    %46 = arith.muli %45, %32 : i64
    %47 = arith.muli %46, %c4_i64 : i64
    %48 = arith.divsi %47, %42 : i64
    %49 = arith.select %33, %48, %30 : i64
    %50 = arith.select %39, %48, %32 : i64
    %from_elements_4 = tensor.from_elements %49, %48, %50, %c4_i64 : tensor<4xi64>
    %reshape_5 = tensor.reshape %reshape(%from_elements_4) : (tensor<?x?x3x?x4xf32>, tensor<4xi64>) -> tensor<?x?x?x4xf32>
    %51 = arith.cmpi slt, %49, %c0_i64 : i64
    %52 = arith.select %51, %c1_i64, %49 : i64
    %53 = arith.extui %51 : i1 to i64
    %54 = arith.muli %52, %48 : i64
    %55 = arith.addi %53, %c1_i64 : i64
    %56 = arith.cmpi slt, %48, %c0_i64 : i64
    %57 = arith.select %56, %52, %54 : i64
    %58 = arith.select %56, %55, %53 : i64
    %59 = arith.addi %58, %c1_i64 : i64
    %60 = arith.cmpi sle, %59, %c1_i64 : i64
    cf.assert %60, "must have at most one inferred (negative) dimension"
    %61 = arith.muli %49, %48 : i64
    %62 = arith.muli %61, %50 : i64
    %63 = arith.muli %62, %c4_i64 : i64
    %64 = arith.divsi %63, %57 : i64
    %65 = arith.select %51, %64, %49 : i64
    %66 = arith.select %56, %64, %48 : i64
    %from_elements_6 = tensor.from_elements %65, %66, %64 : tensor<3xi64>
    %reshape_7 = tensor.reshape %reshape_5(%from_elements_6) : (tensor<?x?x?x4xf32>, tensor<3xi64>) -> tensor<2x12x4xf32>
    return %reshape_7 : tensor<2x12x4xf32>
  }
}

