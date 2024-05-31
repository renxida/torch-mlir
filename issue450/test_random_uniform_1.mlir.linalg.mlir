#map = affine_map<(d0) -> (d0)>
module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_random_uniform() -> tensor<10xf32> {
    %c1442695040888963407_i64 = arith.constant 1442695040888963407 : i64
    %c6364136223846793005_i64 = arith.constant 6364136223846793005 : i64
    %cst = arith.constant 5.4210107999999998E-20 : f64
    %c32_i64 = arith.constant 32 : i64
    %cst_0 = arith.constant 0.000000e+00 : f64
    %global_seed = ml_program.global_load @global_seed : tensor<i64>
    %extracted = tensor.extract %global_seed[] : tensor<i64>
    %0 = arith.muli %extracted, %c6364136223846793005_i64 : i64
    %1 = arith.addi %0, %c1442695040888963407_i64 : i64
    %inserted = tensor.insert %1 into %global_seed[] : tensor<i64>
    ml_program.global_store @global_seed = %inserted : tensor<i64>
    %2 = tensor.empty() : tensor<10xf32>
    %3 = linalg.generic {indexing_maps = [#map], iterator_types = ["parallel"]} outs(%2 : tensor<10xf32>) {
    ^bb0(%out: f32):
      %4 = linalg.index 0 : index
      %5 = arith.index_cast %4 : index to i64
      %6 = arith.muli %5, %1 : i64
      %7 = arith.addi %6, %1 : i64
      %8 = arith.muli %6, %6 : i64
      %9 = arith.addi %8, %6 : i64
      %10 = arith.shli %9, %c32_i64 : i64
      %11 = arith.shrui %9, %c32_i64 : i64
      %12 = arith.ori %10, %11 : i64
      %13 = arith.muli %12, %12 : i64
      %14 = arith.addi %13, %7 : i64
      %15 = arith.shli %14, %c32_i64 : i64
      %16 = arith.shrui %14, %c32_i64 : i64
      %17 = arith.ori %15, %16 : i64
      %18 = arith.muli %17, %17 : i64
      %19 = arith.addi %18, %6 : i64
      %20 = arith.shli %19, %c32_i64 : i64
      %21 = arith.shrui %19, %c32_i64 : i64
      %22 = arith.ori %20, %21 : i64
      %23 = arith.muli %22, %22 : i64
      %24 = arith.addi %23, %7 : i64
      %25 = arith.shli %24, %c32_i64 : i64
      %26 = arith.shrui %24, %c32_i64 : i64
      %27 = arith.ori %25, %26 : i64
      %28 = arith.muli %27, %27 : i64
      %29 = arith.addi %28, %6 : i64
      %30 = arith.shrui %29, %c32_i64 : i64
      %31 = arith.xori %24, %30 : i64
      %32 = arith.uitofp %31 : i64 to f64
      %33 = arith.mulf %32, %cst : f64
      %34 = arith.addf %33, %cst_0 : f64
      %35 = arith.truncf %34 : f64 to f32
      linalg.yield %35 : f32
    } -> tensor<10xf32>
    return %3 : tensor<10xf32>
  }
}

