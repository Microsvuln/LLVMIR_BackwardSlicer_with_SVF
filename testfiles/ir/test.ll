; ModuleID = 'src/test.cpp'
source_filename = "src/test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline norecurse nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %var1 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 1, i32* %n, align 4, !dbg !14
  call void @llvm.dbg.declare(metadata i32* %var1, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 10, i32* %var1, align 4, !dbg !16
  %0 = load i32, i32* %var1, align 4, !dbg !17
  %cmp = icmp sgt i32 %0, 5, !dbg !19
  br i1 %cmp, label %if.then, label %if.else, !dbg !20

if.then:                                          ; preds = %entry
  store i32 2, i32* %n, align 4, !dbg !21
  br label %if.end, !dbg !23

if.else:                                          ; preds = %entry
  store i32 3, i32* %n, align 4, !dbg !24
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret i32 0, !dbg !26
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { mustprogress noinline norecurse nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "src/test.cpp", directory: "/home/lcy/LLVMIR_BackwardSlicer_with_SVF/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"uwtable", i32 1}
!7 = !{i32 7, !"frame-pointer", i32 2}
!8 = !{!"clang version 13.0.0"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !10, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "n", scope: !9, file: !1, line: 3, type: !12)
!14 = !DILocation(line: 3, column: 9, scope: !9)
!15 = !DILocalVariable(name: "var1", scope: !9, file: !1, line: 4, type: !12)
!16 = !DILocation(line: 4, column: 9, scope: !9)
!17 = !DILocation(line: 6, column: 10, scope: !18)
!18 = distinct !DILexicalBlock(scope: !9, file: !1, line: 6, column: 10)
!19 = !DILocation(line: 6, column: 15, scope: !18)
!20 = !DILocation(line: 6, column: 10, scope: !9)
!21 = !DILocation(line: 7, column: 11, scope: !22)
!22 = distinct !DILexicalBlock(scope: !18, file: !1, line: 6, column: 21)
!23 = !DILocation(line: 8, column: 5, scope: !22)
!24 = !DILocation(line: 10, column: 11, scope: !25)
!25 = distinct !DILexicalBlock(scope: !18, file: !1, line: 9, column: 10)
!26 = !DILocation(line: 13, column: 5, scope: !9)
