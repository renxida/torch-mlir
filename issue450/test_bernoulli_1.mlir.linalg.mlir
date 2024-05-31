#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_bernoulli(%arg0: tensor<10xf64>) -> tensor<10xf64> {
    %c32_i64 = arith.constant 32 : i64
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 5.4210107999999998E-20 : f64
    %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
    %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
    %global_seed = ml_program.global_load @global_seed : tensor<i64>
    %extracted = tensor.extract %global_seed[] : tensor<i64>
    %0 = arith.muli %extracted, %c6364136223846793005_i64 : i64
    %1 = arith.addi %0, %c1442695040888963407_i64 : i64
    %inserted = tensor.insert %1 into %global_seed[] : tensor<i64>
    ml_program.global_store @global_seed = %inserted : tensor<i64>
    %2 = tensor.empty() : tensor<10xf64>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<10xf64>) {
    ^bb0(%out: f64):
      %7 = linalg.index 0 : index
      %8 = arith.index_cast %7 : index to i64
      %9 = arith.muli %8, %1 : i64
      %10 = arith.addi %9, %1 : i64
      %11 = arith.muli %9, %9 : i64
      %12 = arith.addi %11, %9 : i64
      %13 = arith.shli %12, %c32_i64 : i64
      %14 = arith.shrui %12, %c32_i64 : i64
      %15 = arith.ori %13, %14 : i64
      %16 = arith.muli %15, %15 : i64
      %17 = arith.addi %16, %10 : i64
      %18 = arith.shli %17, %c32_i64 : i64
      %19 = arith.shrui %17, %c32_i64 : i64
      %20 = arith.ori %18, %19 : i64
      %21 = arith.muli %20, %20 : i64
      %22 = arith.addi %21, %9 : i64
      %23 = arith.shli %22, %c32_i64 : i64
      %24 = arith.shrui %22, %c32_i64 : i64
      %25 = arith.ori %23, %24 : i64
      %26 = arith.muli %25, %25 : i64
      %27 = arith.addi %26, %10 : i64
      %28 = arith.shli %27, %c32_i64 : i64
      %29 = arith.shrui %27, %c32_i64 : i64
      %30 = arith.ori %28, %29 : i64
      %31 = arith.muli %30, %30 : i64
      %32 = arith.addi %31, %9 : i64
      %33 = arith.shrui %32, %c32_i64 : i64
      %34 = arith.xori %27, %33 : i64
      %35 = arith.uitofp %34 : i64 to f64
      %36 = arith.mulf %35, %cst_0 : f64
      %37 = arith.addf %36, %cst : f64
      linalg.yield %37 : f64
    } -> tensor<10xf64>
    %4 = tensor.empty() : tensor<10xi1>
    %5 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%3, %arg0 : tensor<10xf64>, tensor<10xf64>) outs(%4 : tensor<10xi1>) {
    ^bb0(%in: f64, %in_1: f64, %out: i1):
      %7 = arith.cmpf olt, %in, %in_1 : f64
      linalg.yield %7 : i1
    } -> tensor<10xi1>
    %6 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%5 : tensor<10xi1>) outs(%2 : tensor<10xf64>) {
    ^bb0(%in: i1, %out: f64):
      %7 = arith.uitofp %in : i1 to f64
      linalg.yield %7 : f64
    } -> tensor<10xf64>
    return %6 : tensor<10xf64>
  }
}

