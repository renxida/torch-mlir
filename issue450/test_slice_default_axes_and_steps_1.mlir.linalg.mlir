module {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @test_slice_default_axes_and_steps(%arg0: tensor<20x10x5xf32>, %arg1: tensor<1xi64>, %arg2: tensor<1xi64>) -> tensor<20x10x1xf32> {
    %c20_i64 = arith.constant 20 : i64
    %c0_i64 = arith.constant 0 : i64
    %c20 = arith.constant 20 : index
    %c-1 = arith.constant -1 : index
    %c0 = arith.constant 0 : index
    %extracted = tensor.extract %arg1[%c0] : tensor<1xi64>
    %extracted_0 = tensor.extract %arg2[%c0] : tensor<1xi64>
    %0 = arith.addi %extracted, %c20_i64 : i64
    %1 = arith.cmpi sge, %extracted, %c0_i64 : i64
    %2 = arith.select %1, %extracted, %0 : i64
    %3 = arith.cmpi slt, %2, %c0_i64 : i64
    %4 = arith.select %3, %c0_i64, %2 : i64
    %5 = arith.cmpi sgt, %4, %c20_i64 : i64
    %6 = arith.select %5, %c20_i64, %4 : i64
    %7 = arith.index_cast %6 : i64 to index
    %8 = arith.index_cast %extracted_0 : i64 to index
    %9 = arith.cmpi slt, %8, %c0 : index
    %10 = arith.addi %8, %c20 : index
    %11 = arith.select %9, %10, %8 : index
    %12 = arith.cmpi slt, %11, %c0 : index
    %13 = arith.select %12, %c-1, %11 : index
    %14 = arith.cmpi sgt, %13, %c20 : index
    %15 = arith.select %14, %c20, %13 : index
    %16 = arith.subi %15, %7 : index
    %17 = arith.cmpi slt, %16, %c0 : index
    %18 = arith.select %17, %c0, %16 : index
    %extracted_slice = tensor.extract_slice %arg0[%7, 0, 0] [%18, 10, 5] [1, 1, 1] : tensor<20x10x5xf32> to tensor<?x10x5xf32>
    %cast = tensor.cast %extracted_slice : tensor<?x10x5xf32> to tensor<?x?x?xf32>
    %cast_1 = tensor.cast %cast : tensor<?x?x?xf32> to tensor<20x10x1xf32>
    return %cast_1 : tensor<20x10x1xf32>
  }
}

