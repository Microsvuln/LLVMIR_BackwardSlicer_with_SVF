; ModuleID = './src/test_if2.cpp'
source_filename = "./src/test_if2.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %b, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 1, i32* %a, align 4, !dbg !19
  %0 = load i32, i32* %a, align 4, !dbg !20
  %cmp = icmp eq i32 %0, 0, !dbg !22
  br i1 %cmp, label %if.then, label %if.else3, !dbg !23

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %a, align 4, !dbg !24
  %cmp1 = icmp sgt i32 %1, 1, !dbg !27
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !28

if.then2:                                         ; preds = %if.then
  store i32 2, i32* %a, align 4, !dbg !29
  br label %if.end, !dbg !31

if.else:                                          ; preds = %if.then
  store i32 3, i32* %a, align 4, !dbg !32
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  store i32 2, i32* %b, align 4, !dbg !34
  br label %if.end4, !dbg !35

if.else3:                                         ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %c, metadata !36, metadata !DIExpression()), !dbg !38
  store i32 4, i32* %b, align 4, !dbg !39
  store i32 5, i32* %c, align 4, !dbg !40
  br label %if.end4

if.end4:                                          ; preds = %if.else3, %if.end
  store i32 5, i32* %b, align 4, !dbg !41
  ret i32 0, !dbg !42
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_if2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_if2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "a", scope: !10, file: !11, line: 3, type: !14)
!16 = !DILocation(line: 3, column: 9, scope: !10)
!17 = !DILocalVariable(name: "b", scope: !10, file: !11, line: 4, type: !14)
!18 = !DILocation(line: 4, column: 9, scope: !10)
!19 = !DILocation(line: 6, column: 7, scope: !10)
!20 = !DILocation(line: 7, column: 10, scope: !21)
!21 = distinct !DILexicalBlock(scope: !10, file: !11, line: 7, column: 10)
!22 = !DILocation(line: 7, column: 12, scope: !21)
!23 = !DILocation(line: 7, column: 10, scope: !10)
!24 = !DILocation(line: 8, column: 14, scope: !25)
!25 = distinct !DILexicalBlock(scope: !26, file: !11, line: 8, column: 14)
!26 = distinct !DILexicalBlock(scope: !21, file: !11, line: 7, column: 19)
!27 = !DILocation(line: 8, column: 16, scope: !25)
!28 = !DILocation(line: 8, column: 14, scope: !26)
!29 = !DILocation(line: 9, column: 15, scope: !30)
!30 = distinct !DILexicalBlock(scope: !25, file: !11, line: 8, column: 22)
!31 = !DILocation(line: 10, column: 9, scope: !30)
!32 = !DILocation(line: 12, column: 15, scope: !33)
!33 = distinct !DILexicalBlock(scope: !25, file: !11, line: 11, column: 14)
!34 = !DILocation(line: 14, column: 11, scope: !26)
!35 = !DILocation(line: 15, column: 5, scope: !26)
!36 = !DILocalVariable(name: "c", scope: !37, file: !11, line: 17, type: !14)
!37 = distinct !DILexicalBlock(scope: !21, file: !11, line: 16, column: 10)
!38 = !DILocation(line: 17, column: 13, scope: !37)
!39 = !DILocation(line: 18, column: 11, scope: !37)
!40 = !DILocation(line: 19, column: 11, scope: !37)
!41 = !DILocation(line: 22, column: 7, scope: !10)
!42 = !DILocation(line: 23, column: 5, scope: !10)
