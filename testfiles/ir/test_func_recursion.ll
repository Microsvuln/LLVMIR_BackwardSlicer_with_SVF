; ModuleID = './src/test_func_recursion.cpp'
source_filename = "./src/test_func_recursion.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline optnone ssp uwtable
define i32 @_Z3fooi(i32 %a) #0 !dbg !11 {
entry:
  %retval = alloca i32, align 4
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !16, metadata !DIExpression()), !dbg !17
  %0 = load i32, i32* %a.addr, align 4, !dbg !18
  %cmp = icmp sgt i32 %0, 100, !dbg !20
  br i1 %cmp, label %if.then, label %if.end, !dbg !21

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %a.addr, align 4, !dbg !22
  store i32 %1, i32* %retval, align 4, !dbg !24
  br label %return, !dbg !24

if.end:                                           ; preds = %entry
  %2 = load i32, i32* %a.addr, align 4, !dbg !25
  %call = call i32 @_Z3fooi(i32 %2), !dbg !26
  %add = add nsw i32 %call, 1, !dbg !27
  store i32 %add, i32* %retval, align 4, !dbg !28
  br label %return, !dbg !28

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !dbg !29
  ret i32 %3, !dbg !29
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #2 !dbg !30 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @_Z3fooi(i32 1), !dbg !33
  ret i32 0, !dbg !34
}

attributes #0 = { mustprogress noinline optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

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
!8 = !DIFile(filename: "src/test_func_recursion.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!9 = !{}
!10 = !{!"clang version 13.0.0"}
!11 = distinct !DISubprogram(name: "foo", linkageName: "_Z3fooi", scope: !12, file: !12, line: 1, type: !13, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!12 = !DIFile(filename: "./src/test_func_recursion.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !11, file: !12, line: 1, type: !15)
!17 = !DILocation(line: 1, column: 14, scope: !11)
!18 = !DILocation(line: 3, column: 10, scope: !19)
!19 = distinct !DILexicalBlock(scope: !11, file: !12, line: 3, column: 10)
!20 = !DILocation(line: 3, column: 12, scope: !19)
!21 = !DILocation(line: 3, column: 10, scope: !11)
!22 = !DILocation(line: 5, column: 16, scope: !23)
!23 = distinct !DILexicalBlock(scope: !19, file: !12, line: 4, column: 5)
!24 = !DILocation(line: 5, column: 9, scope: !23)
!25 = !DILocation(line: 8, column: 17, scope: !11)
!26 = !DILocation(line: 8, column: 12, scope: !11)
!27 = !DILocation(line: 8, column: 21, scope: !11)
!28 = !DILocation(line: 8, column: 5, scope: !11)
!29 = !DILocation(line: 9, column: 1, scope: !11)
!30 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 11, type: !31, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!31 = !DISubroutineType(types: !32)
!32 = !{!15}
!33 = !DILocation(line: 13, column: 5, scope: !30)
!34 = !DILocation(line: 15, column: 5, scope: !30)
