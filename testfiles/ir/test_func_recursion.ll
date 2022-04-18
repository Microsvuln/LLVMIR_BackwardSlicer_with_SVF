; ModuleID = './src/test_func_recursion.cpp'
source_filename = "./src/test_func_recursion.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline optnone ssp uwtable
define i32 @_Z3fooi(i32 %a) #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, i32* %a.addr, align 4, !dbg !17
  %cmp = icmp sgt i32 %0, 100, !dbg !19
  br i1 %cmp, label %if.then, label %if.end, !dbg !20

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %a.addr, align 4, !dbg !21
  store i32 %1, i32* %retval, align 4, !dbg !23
  br label %return, !dbg !23

if.end:                                           ; preds = %entry
  %2 = load i32, i32* %a.addr, align 4, !dbg !24
  %call = call i32 @_Z3fooi(i32 %2), !dbg !25
  %add = add nsw i32 %call, 1, !dbg !26
  store i32 %add, i32* %retval, align 4, !dbg !27
  br label %return, !dbg !27

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !dbg !28
  ret i32 %3, !dbg !28
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #2 !dbg !29 {
entry:
  %retval = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %result, metadata !32, metadata !DIExpression()), !dbg !33
  %call = call i32 @_Z3fooi(i32 1), !dbg !34
  store i32 %call, i32* %result, align 4, !dbg !35
  ret i32 0, !dbg !36
}

attributes #0 = { mustprogress noinline optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_func_recursion.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "foo", linkageName: "_Z3fooi", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_func_recursion.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14, !14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!16 = !DILocation(line: 1, column: 14, scope: !10)
!17 = !DILocation(line: 3, column: 10, scope: !18)
!18 = distinct !DILexicalBlock(scope: !10, file: !11, line: 3, column: 10)
!19 = !DILocation(line: 3, column: 12, scope: !18)
!20 = !DILocation(line: 3, column: 10, scope: !10)
!21 = !DILocation(line: 5, column: 16, scope: !22)
!22 = distinct !DILexicalBlock(scope: !18, file: !11, line: 4, column: 5)
!23 = !DILocation(line: 5, column: 9, scope: !22)
!24 = !DILocation(line: 8, column: 17, scope: !10)
!25 = !DILocation(line: 8, column: 12, scope: !10)
!26 = !DILocation(line: 8, column: 21, scope: !10)
!27 = !DILocation(line: 8, column: 5, scope: !10)
!28 = !DILocation(line: 9, column: 1, scope: !10)
!29 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 11, type: !30, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!14}
!32 = !DILocalVariable(name: "result", scope: !29, file: !11, line: 13, type: !14)
!33 = !DILocation(line: 13, column: 9, scope: !29)
!34 = !DILocation(line: 14, column: 14, scope: !29)
!35 = !DILocation(line: 14, column: 12, scope: !29)
!36 = !DILocation(line: 16, column: 5, scope: !29)
