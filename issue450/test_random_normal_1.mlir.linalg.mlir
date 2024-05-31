#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_random_normal() -> tensor<10xf32> {
    %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
    %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %cst_0 = arith.constant -2.000000e+00 : f32
    %cst_1 = arith.constant 5.4210107999999998E-20 : f64
    %c32_i64 = arith.constant 32 : i64
    %cst_2 = arith.constant 6.283180e+00 : f64
    %cst_3 = arith.constant 0.000000e+00 : f64
    %global_seed = ml_program.global_load @global_seed : tensor<i64>
    %extracted = tensor.extract %global_seed[] : tensor<i64>
    %0 = arith.muli %extracted, %c6364136223846793005_i64 : i64
    %1 = arith.addi %0, %c1442695040888963407_i64 : i64
    %inserted = tensor.insert %1 into %global_seed[] : tensor<i64>
    ml_program.global_store @global_seed = %inserted : tensor<i64>
    %2 = tensor.empty() : tensor<10xf32>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<10xf32>) {
    ^bb0(%out: f32):
      %14 = linalg.index 0 : index
      %15 = arith.index_cast %14 : index to i64
      %16 = arith.muli %15, %1 : i64
      %17 = arith.addi %16, %1 : i64
      %18 = arith.muli %16, %16 : i64
      %19 = arith.addi %18, %16 : i64
      %20 = arith.shli %19, %c32_i64 : i64
      %21 = arith.shrui %19, %c32_i64 : i64
      %22 = arith.ori %20, %21 : i64
      %23 = arith.muli %22, %22 : i64
      %24 = arith.addi %23, %17 : i64
      %25 = arith.shli %24, %c32_i64 : i64
      %26 = arith.shrui %24, %c32_i64 : i64
      %27 = arith.ori %25, %26 : i64
      %28 = arith.muli %27, %27 : i64
      %29 = arith.addi %28, %16 : i64
      %30 = arith.shli %29, %c32_i64 : i64
      %31 = arith.shrui %29, %c32_i64 : i64
      %32 = arith.ori %30, %31 : i64
      %33 = arith.muli %32, %32 : i64
      %34 = arith.addi %33, %17 : i64
      %35 = arith.shli %34, %c32_i64 : i64
      %36 = arith.shrui %34, %c32_i64 : i64
      %37 = arith.ori %35, %36 : i64
      %38 = arith.muli %37, %37 : i64
      %39 = arith.addi %38, %16 : i64
      %40 = arith.shrui %39, %c32_i64 : i64
      %41 = arith.xori %34, %40 : i64
      %42 = arith.uitofp %41 : i64 to f64
      %43 = arith.mulf %42, %cst_1 : f64
      %44 = arith.addf %43, %cst_3 : f64
      %45 = arith.truncf %44 : f64 to f32
      linalg.yield %45 : f32
    } -> tensor<10xf32>
    %global_seed_4 = ml_program.global_load @global_seed : tensor<i64>
    %extracted_5 = tensor.extract %global_seed_4[] : tensor<i64>
    %4 = arith.muli %extracted_5, %c6364136223846793005_i64 : i64
    %5 = arith.addi %4, %c1442695040888963407_i64 : i64
    %inserted_6 = tensor.insert %5 into %global_seed_4[] : tensor<i64>
    ml_program.global_store @global_seed = %inserted_6 : tensor<i64>
    %6 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<10xf32>) {
    ^bb0(%out: f32):
      %14 = linalg.index 0 : index
      %15 = arith.index_cast %14 : index to i64
      %16 = arith.muli %15, %5 : i64
      %17 = arith.addi %16, %5 : i64
      %18 = arith.muli %16, %16 : i64
      %19 = arith.addi %18, %16 : i64
      %20 = arith.shli %19, %c32_i64 : i64
      %21 = arith.shrui %19, %c32_i64 : i64
      %22 = arith.ori %20, %21 : i64
      %23 = arith.muli %22, %22 : i64
      %24 = arith.addi %23, %17 : i64
      %25 = arith.shli %24, %c32_i64 : i64
      %26 = arith.shrui %24, %c32_i64 : i64
      %27 = arith.ori %25, %26 : i64
      %28 = arith.muli %27, %27 : i64
      %29 = arith.addi %28, %16 : i64
      %30 = arith.shli %29, %c32_i64 : i64
      %31 = arith.shrui %29, %c32_i64 : i64
      %32 = arith.ori %30, %31 : i64
      %33 = arith.muli %32, %32 : i64
      %34 = arith.addi %33, %17 : i64
      %35 = arith.shli %34, %c32_i64 : i64
      %36 = arith.shrui %34, %c32_i64 : i64
      %37 = arith.ori %35, %36 : i64
      %38 = arith.muli %37, %37 : i64
      %39 = arith.addi %38, %16 : i64
      %40 = arith.shrui %39, %c32_i64 : i64
      %41 = arith.xori %34, %40 : i64
      %42 = arith.uitofp %41 : i64 to f64
      %43 = arith.mulf %42, %cst_1 : f64
      %44 = arith.addf %43, %cst_3 : f64
      %45 = arith.truncf %44 : f64 to f32
      linalg.yield %45 : f32
    } -> tensor<10xf32>
    %7 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%3 : tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = math.log %in : f32
      linalg.yield %14 : f32
    } -> tensor<10xf32>
    %8 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%7 : tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = arith.mulf %in, %cst_0 : f32
      linalg.yield %14 : f32
    } -> tensor<10xf32>
    %9 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%8 : tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = math.sqrt %in : f32
      linalg.yield %14 : f32
    } -> tensor<10xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%6 : tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = arith.truncf %cst_2 : f64 to f32
      %15 = arith.mulf %in, %14 : f32
      linalg.yield %15 : f32
    } -> tensor<10xf32>
    %11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%10 : tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = math.cos %in : f32
      linalg.yield %14 : f32
    } -> tensor<10xf32>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%9, %11 : tensor<10xf32>, tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %in_7: f32, %out: f32):
      %14 = arith.mulf %in, %in_7 : f32
      linalg.yield %14 : f32
    } -> tensor<10xf32>
    %13 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%12 : tensor<10xf32>) outs(%2 : tensor<10xf32>) {
    ^bb0(%in: f32, %out: f32):
      %14 = arith.addf %in, %cst : f32
      linalg.yield %14 : f32
    } -> tensor<10xf32>
    return %13 : tensor<10xf32>
  }
}

