; ModuleID = './src/test_if.cpp'
source_filename = "./src/test_if.cpp"
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
  %cmp = icmp eq i32 %0, 1, !dbg !21
  br i1 %cmp, label %if.then, label %if.else, !dbg !22

if.then:                                          ; preds = %entry
  store i32 1, i32* %s, align 4, !dbg !23
  br label %if.end, !dbg !25

if.else:                                          ; preds = %entry
  store i32 2, i32* %s, align 4, !dbg !26
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %1 = load i32, i32* %n, align 4, !dbg !28
  %cmp1 = icmp eq i32 %1, 1, !dbg !30
  br i1 %cmp1, label %land.lhs.true, label %if.else4, !dbg !31

land.lhs.true:                                    ; preds = %if.end
  %2 = load i32, i32* %s, align 4, !dbg !32
  %cmp2 = icmp eq i32 %2, 2, !dbg !33
  br i1 %cmp2, label %if.then3, label %if.else4, !dbg !34

if.then3:                                         ; preds = %land.lhs.true
  store i32 1, i32* %s, align 4, !dbg !35
  br label %if.end9, !dbg !37

if.else4:                                         ; preds = %land.lhs.true, %if.end
  %3 = load i32, i32* %n, align 4, !dbg !38
  %cmp5 = icmp eq i32 %3, 1, !dbg !40
  br i1 %cmp5, label %if.then6, label %if.else7, !dbg !41

if.then6:                                         ; preds = %if.else4
  store i32 2, i32* %s, align 4, !dbg !42
  br label %if.end8, !dbg !44

if.else7:                                         ; preds = %if.else4
  store i32 3, i32* %s, align 4, !dbg !45
  br label %if.end8

if.end8:                                          ; preds = %if.else7, %if.then6
  br label %if.end9

if.end9:                                          ; preds = %if.end8, %if.then3
  ret i32 0, !dbg !47
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "Homebrew clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk", sdk: "MacOSX12.sdk")
!1 = !DIFile(filename: "src/test_if.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Homebrew clang version 13.0.1"}
!10 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_if.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "n", scope: !10, file: !11, line: 3, type: !14)
!16 = !DILocation(line: 3, column: 9, scope: !10)
!17 = !DILocalVariable(name: "s", scope: !10, file: !11, line: 4, type: !14)
!18 = !DILocation(line: 4, column: 9, scope: !10)
!19 = !DILocation(line: 6, column: 10, scope: !20)
!20 = distinct !DILexicalBlock(scope: !10, file: !11, line: 6, column: 10)
!21 = !DILocation(line: 6, column: 12, scope: !20)
!22 = !DILocation(line: 6, column: 10, scope: !10)
!23 = !DILocation(line: 7, column: 11, scope: !24)
!24 = distinct !DILexicalBlock(scope: !20, file: !11, line: 6, column: 19)
!25 = !DILocation(line: 8, column: 5, scope: !24)
!26 = !DILocation(line: 10, column: 11, scope: !27)
!27 = distinct !DILexicalBlock(scope: !20, file: !11, line: 9, column: 10)
!28 = !DILocation(line: 13, column: 10, scope: !29)
!29 = distinct !DILexicalBlock(scope: !10, file: !11, line: 13, column: 10)
!30 = !DILocation(line: 13, column: 12, scope: !29)
!31 = !DILocation(line: 13, column: 17, scope: !29)
!32 = !DILocation(line: 13, column: 20, scope: !29)
!33 = !DILocation(line: 13, column: 22, scope: !29)
!34 = !DILocation(line: 13, column: 10, scope: !10)
!35 = !DILocation(line: 14, column: 11, scope: !36)
!36 = distinct !DILexicalBlock(scope: !29, file: !11, line: 13, column: 29)
!37 = !DILocation(line: 15, column: 5, scope: !36)
!38 = !DILocation(line: 16, column: 15, scope: !39)
!39 = distinct !DILexicalBlock(scope: !29, file: !11, line: 16, column: 15)
!40 = !DILocation(line: 16, column: 17, scope: !39)
!41 = !DILocation(line: 16, column: 15, scope: !29)
!42 = !DILocation(line: 17, column: 11, scope: !43)
!43 = distinct !DILexicalBlock(scope: !39, file: !11, line: 16, column: 23)
!44 = !DILocation(line: 18, column: 5, scope: !43)
!45 = !DILocation(line: 20, column: 11, scope: !46)
!46 = distinct !DILexicalBlock(scope: !39, file: !11, line: 19, column: 10)
!47 = !DILocation(line: 24, column: 5, scope: !10)
