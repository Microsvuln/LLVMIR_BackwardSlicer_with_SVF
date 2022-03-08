; ModuleID = './src/test_array.cpp'
source_filename = "./src/test_array.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #0 !dbg !11 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32*, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32** %a, metadata !16, metadata !DIExpression()), !dbg !18
  %call = call noalias nonnull i8* @_Znam(i64 16) #3, !dbg !19, !heapallocsite !15
  %0 = bitcast i8* %call to i32*, !dbg !19
  store i32* %0, i32** %a, align 8, !dbg !20
  %1 = load i32*, i32** %a, align 8, !dbg !21
  %arrayidx = getelementptr inbounds i32, i32* %1, i64 0, !dbg !21
  store i32 1, i32* %arrayidx, align 4, !dbg !22
  %2 = load i32*, i32** %a, align 8, !dbg !23
  %arrayidx1 = getelementptr inbounds i32, i32* %2, i64 1, !dbg !23
  store i32 2, i32* %arrayidx1, align 4, !dbg !24
  %3 = load i32*, i32** %a, align 8, !dbg !25
  %arrayidx2 = getelementptr inbounds i32, i32* %3, i64 2, !dbg !25
  store i32 3, i32* %arrayidx2, align 4, !dbg !26
  %4 = load i32*, i32** %a, align 8, !dbg !27
  %arrayidx3 = getelementptr inbounds i32, i32* %4, i64 3, !dbg !27
  store i32 4, i32* %arrayidx3, align 4, !dbg !28
  call void @llvm.dbg.declare(metadata i32* %i, metadata !29, metadata !DIExpression()), !dbg !31
  store i32 0, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !32

for.cond:                                         ; preds = %for.inc, %entry
  %5 = load i32, i32* %i, align 4, !dbg !33
  %cmp = icmp slt i32 %5, 4, !dbg !35
  br i1 %cmp, label %for.body, label %for.end, !dbg !36

for.body:                                         ; preds = %for.cond
  %6 = load i32, i32* %i, align 4, !dbg !37
  %7 = load i32*, i32** %a, align 8, !dbg !39
  %8 = load i32, i32* %i, align 4, !dbg !40
  %idxprom = sext i32 %8 to i64, !dbg !39
  %arrayidx4 = getelementptr inbounds i32, i32* %7, i64 %idxprom, !dbg !39
  store i32 %6, i32* %arrayidx4, align 4, !dbg !41
  br label %for.inc, !dbg !42

for.inc:                                          ; preds = %for.body
  %9 = load i32, i32* %i, align 4, !dbg !43
  %inc = add nsw i32 %9, 1, !dbg !43
  store i32 %inc, i32* %i, align 4, !dbg !43
  br label %for.cond, !dbg !44, !llvm.loop !45

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !48
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nobuiltin allocsize(0)
declare nonnull i8* @_Znam(i64) #2

attributes #0 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nobuiltin allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #3 = { builtin allocsize(0) }

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
!8 = !DIFile(filename: "src/test_array.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!9 = !{}
!10 = !{!"clang version 13.0.0"}
!11 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 1, type: !13, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!12 = !DIFile(filename: "./src/test_array.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!13 = !DISubroutineType(types: !14)
!14 = !{!15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "a", scope: !11, file: !12, line: 3, type: !17)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!18 = !DILocation(line: 3, column: 10, scope: !11)
!19 = !DILocation(line: 4, column: 9, scope: !11)
!20 = !DILocation(line: 4, column: 7, scope: !11)
!21 = !DILocation(line: 5, column: 5, scope: !11)
!22 = !DILocation(line: 5, column: 10, scope: !11)
!23 = !DILocation(line: 6, column: 5, scope: !11)
!24 = !DILocation(line: 6, column: 10, scope: !11)
!25 = !DILocation(line: 7, column: 5, scope: !11)
!26 = !DILocation(line: 7, column: 10, scope: !11)
!27 = !DILocation(line: 8, column: 5, scope: !11)
!28 = !DILocation(line: 8, column: 10, scope: !11)
!29 = !DILocalVariable(name: "i", scope: !30, file: !12, line: 10, type: !15)
!30 = distinct !DILexicalBlock(scope: !11, file: !12, line: 10, column: 5)
!31 = !DILocation(line: 10, column: 15, scope: !30)
!32 = !DILocation(line: 10, column: 11, scope: !30)
!33 = !DILocation(line: 10, column: 22, scope: !34)
!34 = distinct !DILexicalBlock(scope: !30, file: !12, line: 10, column: 5)
!35 = !DILocation(line: 10, column: 24, scope: !34)
!36 = !DILocation(line: 10, column: 5, scope: !30)
!37 = !DILocation(line: 11, column: 16, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !12, line: 10, column: 36)
!39 = !DILocation(line: 11, column: 9, scope: !38)
!40 = !DILocation(line: 11, column: 11, scope: !38)
!41 = !DILocation(line: 11, column: 14, scope: !38)
!42 = !DILocation(line: 12, column: 5, scope: !38)
!43 = !DILocation(line: 10, column: 31, scope: !34)
!44 = !DILocation(line: 10, column: 5, scope: !34)
!45 = distinct !{!45, !36, !46, !47}
!46 = !DILocation(line: 12, column: 5, scope: !30)
!47 = !{!"llvm.loop.mustprogress"}
!48 = !DILocation(line: 14, column: 5, scope: !11)
