; ModuleID = './src/test_func.cpp'
source_filename = "./src/test_func.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z3fooi(i32 %a) #0 !dbg !11 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !16, metadata !DIExpression()), !dbg !17
  %0 = load i32, i32* %a.addr, align 4, !dbg !18
  %add = add nsw i32 %0, 1, !dbg !19
  ret i32 %add, !dbg !20
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !21 {
entry:
  %retval = alloca i32, align 4
  %local = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %local, metadata !24, metadata !DIExpression()), !dbg !25
  store i32 1, i32* %local, align 4, !dbg !25
  %0 = load i32, i32* %local, align 4, !dbg !26
  %call = call i32 @_Z3fooi(i32 %0), !dbg !27
  store i32 %call, i32* %local, align 4, !dbg !28
  ret i32 0, !dbg !29
}

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6}
!llvm.dbg.cu = !{!7}
!llvm.ident = !{!10}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 1]}
!1 = !{i32 7, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 7, !"PIC Level", i32 2}
!5 = !{i32 7, !"uwtable", i32 1}
!6 = !{i32 7, !"frame-pointer", i32 2}
!7 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !8, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !9, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk", sdk: "MacOSX.sdk")
!8 = !DIFile(filename: "src/test_func.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!9 = !{}
!10 = !{!"clang version 13.0.0"}
!11 = distinct !DISubprogram(name: "foo", linkageName: "_Z3fooi", scope: !12, file: !12, line: 1, type: !13, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!12 = !DIFile(filename: "./src/test_func.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !11, file: !12, line: 1, type: !15)
!17 = !DILocation(line: 1, column: 14, scope: !11)
!18 = !DILocation(line: 3, column: 12, scope: !11)
!19 = !DILocation(line: 3, column: 14, scope: !11)
!20 = !DILocation(line: 3, column: 5, scope: !11)
!21 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 6, type: !22, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!22 = !DISubroutineType(types: !23)
!23 = !{!15}
!24 = !DILocalVariable(name: "local", scope: !21, file: !12, line: 8, type: !15)
!25 = !DILocation(line: 8, column: 9, scope: !21)
!26 = !DILocation(line: 10, column: 18, scope: !21)
!27 = !DILocation(line: 10, column: 13, scope: !21)
!28 = !DILocation(line: 10, column: 11, scope: !21)
!29 = !DILocation(line: 11, column: 5, scope: !21)
