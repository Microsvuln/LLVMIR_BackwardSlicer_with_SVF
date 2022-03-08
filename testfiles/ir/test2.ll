; ModuleID = './src/test2.cpp'
source_filename = "./src/test2.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %s = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 1, i32* %n, align 4, !dbg !16
  call void @llvm.dbg.declare(metadata i32* %s, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 2, i32* %s, align 4, !dbg !18
  %0 = load i32, i32* %n, align 4, !dbg !19
  %add = add nsw i32 %0, 1, !dbg !19
  store i32 %add, i32* %n, align 4, !dbg !19
  %1 = load i32, i32* %s, align 4, !dbg !20
  %add1 = add nsw i32 %1, 1, !dbg !20
  store i32 %add1, i32* %s, align 4, !dbg !20
  %2 = load i32, i32* %n, align 4, !dbg !21
  %sub = sub nsw i32 %2, 1, !dbg !21
  store i32 %sub, i32* %n, align 4, !dbg !21
  %3 = load i32, i32* %s, align 4, !dbg !22
  %mul = mul nsw i32 %3, 3, !dbg !22
  store i32 %mul, i32* %s, align 4, !dbg !22
  %4 = load i32, i32* %n, align 4, !dbg !23
  %mul2 = mul nsw i32 %4, 3, !dbg !23
  store i32 %mul2, i32* %n, align 4, !dbg !23
  %5 = load i32, i32* %n, align 4, !dbg !24
  %div = sdiv i32 %5, 3, !dbg !24
  store i32 %div, i32* %n, align 4, !dbg !24
  %6 = load i32, i32* %s, align 4, !dbg !25
  %7 = load i32, i32* %n, align 4, !dbg !26
  %add3 = add nsw i32 %7, %6, !dbg !26
  store i32 %add3, i32* %n, align 4, !dbg !26
  ret i32 0, !dbg !27
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "Homebrew clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk", sdk: "MacOSX12.sdk")
!1 = !DIFile(filename: "src/test2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Homebrew clang version 13.0.1"}
!10 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "n", scope: !10, file: !11, line: 3, type: !14)
!16 = !DILocation(line: 3, column: 9, scope: !10)
!17 = !DILocalVariable(name: "s", scope: !10, file: !11, line: 4, type: !14)
!18 = !DILocation(line: 4, column: 9, scope: !10)
!19 = !DILocation(line: 6, column: 7, scope: !10)
!20 = !DILocation(line: 7, column: 7, scope: !10)
!21 = !DILocation(line: 8, column: 7, scope: !10)
!22 = !DILocation(line: 9, column: 7, scope: !10)
!23 = !DILocation(line: 10, column: 7, scope: !10)
!24 = !DILocation(line: 11, column: 7, scope: !10)
!25 = !DILocation(line: 13, column: 10, scope: !10)
!26 = !DILocation(line: 13, column: 7, scope: !10)
!27 = !DILocation(line: 15, column: 5, scope: !10)
