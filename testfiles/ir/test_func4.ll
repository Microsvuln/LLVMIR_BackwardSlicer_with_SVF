; ModuleID = './src/test_func4.cpp'
source_filename = "./src/test_func4.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z4foo1i(i32 %a) #0 !dbg !10 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, i32* %a.addr, align 4, !dbg !17
  %add = add nsw i32 %0, 1, !dbg !18
  ret i32 %add, !dbg !19
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z4foo2i(i32 %a) #0 !dbg !20 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load i32, i32* %a.addr, align 4, !dbg !23
  %call = call i32 @_Z4foo1i(i32 %0), !dbg !24
  %add = add nsw i32 %call, 1, !dbg !25
  ret i32 %add, !dbg !26
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z4foo3i(i32 %a) #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !28, metadata !DIExpression()), !dbg !29
  %0 = load i32, i32* %a.addr, align 4, !dbg !30
  %cmp = icmp sgt i32 %0, 100, !dbg !32
  br i1 %cmp, label %if.then, label %if.end, !dbg !33

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %a.addr, align 4, !dbg !34
  store i32 %1, i32* %retval, align 4, !dbg !36
  br label %return, !dbg !36

if.end:                                           ; preds = %entry
  %2 = load i32, i32* %a.addr, align 4, !dbg !37
  %call = call i32 @_Z4foo2i(i32 %2), !dbg !38
  %add = add nsw i32 %call, 1, !dbg !39
  store i32 %add, i32* %retval, align 4, !dbg !40
  br label %return, !dbg !40

return:                                           ; preds = %if.end, %if.then
  %3 = load i32, i32* %retval, align 4, !dbg !41
  ret i32 %3, !dbg !41
}

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !42 {
entry:
  %retval = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %result, metadata !45, metadata !DIExpression()), !dbg !46
  %call = call i32 @_Z4foo3i(i32 1), !dbg !47
  store i32 %call, i32* %result, align 4, !dbg !48
  ret i32 0, !dbg !49
}

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_func4.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "foo1", linkageName: "_Z4foo1i", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_func4.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14, !14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!16 = !DILocation(line: 1, column: 15, scope: !10)
!17 = !DILocation(line: 3, column: 12, scope: !10)
!18 = !DILocation(line: 3, column: 14, scope: !10)
!19 = !DILocation(line: 3, column: 5, scope: !10)
!20 = distinct !DISubprogram(name: "foo2", linkageName: "_Z4foo2i", scope: !11, file: !11, line: 6, type: !12, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !11, line: 6, type: !14)
!22 = !DILocation(line: 6, column: 15, scope: !20)
!23 = !DILocation(line: 8, column: 18, scope: !20)
!24 = !DILocation(line: 8, column: 12, scope: !20)
!25 = !DILocation(line: 8, column: 22, scope: !20)
!26 = !DILocation(line: 8, column: 5, scope: !20)
!27 = distinct !DISubprogram(name: "foo3", linkageName: "_Z4foo3i", scope: !11, file: !11, line: 11, type: !12, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!28 = !DILocalVariable(name: "a", arg: 1, scope: !27, file: !11, line: 11, type: !14)
!29 = !DILocation(line: 11, column: 15, scope: !27)
!30 = !DILocation(line: 13, column: 10, scope: !31)
!31 = distinct !DILexicalBlock(scope: !27, file: !11, line: 13, column: 10)
!32 = !DILocation(line: 13, column: 12, scope: !31)
!33 = !DILocation(line: 13, column: 10, scope: !27)
!34 = !DILocation(line: 15, column: 16, scope: !35)
!35 = distinct !DILexicalBlock(scope: !31, file: !11, line: 14, column: 5)
!36 = !DILocation(line: 15, column: 9, scope: !35)
!37 = !DILocation(line: 18, column: 18, scope: !27)
!38 = !DILocation(line: 18, column: 12, scope: !27)
!39 = !DILocation(line: 18, column: 22, scope: !27)
!40 = !DILocation(line: 18, column: 5, scope: !27)
!41 = !DILocation(line: 19, column: 1, scope: !27)
!42 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 21, type: !43, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!14}
!45 = !DILocalVariable(name: "result", scope: !42, file: !11, line: 23, type: !14)
!46 = !DILocation(line: 23, column: 9, scope: !42)
!47 = !DILocation(line: 24, column: 14, scope: !42)
!48 = !DILocation(line: 24, column: 12, scope: !42)
!49 = !DILocation(line: 26, column: 5, scope: !42)
