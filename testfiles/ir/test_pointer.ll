; ModuleID = './src/test_pointer.cpp'
source_filename = "./src/test_pointer.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #0 !dbg !11 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %np = alloca i32*, align 8
  %npp = alloca i32**, align 8
  %rp = alloca i32*, align 8
  %i = alloca i32, align 4
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  %a = alloca i32**, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 1, i32* %n, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32** %np, metadata !18, metadata !DIExpression()), !dbg !20
  store i32* %n, i32** %np, align 8, !dbg !20
  call void @llvm.dbg.declare(metadata i32*** %npp, metadata !21, metadata !DIExpression()), !dbg !23
  store i32** %np, i32*** %npp, align 8, !dbg !23
  call void @llvm.dbg.declare(metadata i32** %rp, metadata !24, metadata !DIExpression()), !dbg !25
  store i32* %n, i32** %rp, align 8, !dbg !25
  %0 = load i32**, i32*** %npp, align 8, !dbg !26
  %1 = load i32*, i32** %0, align 8, !dbg !27
  store i32 2, i32* %1, align 4, !dbg !28
  store i32** %rp, i32*** %npp, align 8, !dbg !29
  %2 = load i32**, i32*** %npp, align 8, !dbg !30
  %3 = load i32*, i32** %2, align 8, !dbg !31
  store i32 3, i32* %3, align 4, !dbg !32
  call void @llvm.dbg.declare(metadata i32* %i, metadata !33, metadata !DIExpression()), !dbg !35
  store i32 0, i32* %i, align 4, !dbg !35
  br label %for.cond, !dbg !36

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %i, align 4, !dbg !37
  %cmp = icmp slt i32 %4, 4, !dbg !39
  br i1 %cmp, label %for.body, label %for.end, !dbg !40

for.body:                                         ; preds = %for.cond
  %5 = load i32, i32* %i, align 4, !dbg !41
  %rem = srem i32 %5, 2, !dbg !44
  %cmp1 = icmp eq i32 %rem, 0, !dbg !45
  br i1 %cmp1, label %if.then, label %if.else, !dbg !46

if.then:                                          ; preds = %for.body
  store i32** %rp, i32*** %npp, align 8, !dbg !47
  %6 = load i32**, i32*** %npp, align 8, !dbg !49
  %7 = load i32*, i32** %6, align 8, !dbg !50
  store i32 4, i32* %7, align 4, !dbg !51
  br label %if.end, !dbg !52

if.else:                                          ; preds = %for.body
  store i32** %np, i32*** %npp, align 8, !dbg !53
  %8 = load i32**, i32*** %npp, align 8, !dbg !55
  %9 = load i32*, i32** %8, align 8, !dbg !56
  store i32 5, i32* %9, align 4, !dbg !57
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc, !dbg !58

for.inc:                                          ; preds = %if.end
  %10 = load i32, i32* %i, align 4, !dbg !59
  %inc = add nsw i32 %10, 1, !dbg !59
  store i32 %inc, i32* %i, align 4, !dbg !59
  br label %for.cond, !dbg !60, !llvm.loop !61

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %n1, metadata !64, metadata !DIExpression()), !dbg !65
  store i32 6, i32* %n1, align 4, !dbg !65
  call void @llvm.dbg.declare(metadata i32* %n2, metadata !66, metadata !DIExpression()), !dbg !67
  store i32 7, i32* %n2, align 4, !dbg !67
  call void @llvm.dbg.declare(metadata i32*** %a, metadata !68, metadata !DIExpression()), !dbg !69
  %call = call noalias nonnull i8* @_Znam(i64 16) #3, !dbg !70, !heapallocsite !19
  %11 = bitcast i8* %call to i32**, !dbg !70
  store i32** %11, i32*** %a, align 8, !dbg !69
  %12 = load i32**, i32*** %a, align 8, !dbg !71
  %arrayidx = getelementptr inbounds i32*, i32** %12, i64 0, !dbg !71
  store i32* %n1, i32** %arrayidx, align 8, !dbg !72
  %13 = load i32**, i32*** %a, align 8, !dbg !73
  %arrayidx2 = getelementptr inbounds i32*, i32** %13, i64 1, !dbg !73
  store i32* %n2, i32** %arrayidx2, align 8, !dbg !74
  %14 = load i32**, i32*** %a, align 8, !dbg !75
  %arrayidx3 = getelementptr inbounds i32*, i32** %14, i64 0, !dbg !75
  %15 = load i32*, i32** %arrayidx3, align 8, !dbg !75
  store i32 8, i32* %15, align 4, !dbg !76
  %16 = load i32**, i32*** %a, align 8, !dbg !77
  %arrayidx4 = getelementptr inbounds i32*, i32** %16, i64 1, !dbg !77
  %17 = load i32*, i32** %arrayidx4, align 8, !dbg !77
  store i32 9, i32* %17, align 4, !dbg !78
  ret i32 0, !dbg !79
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
!8 = !DIFile(filename: "src/test_pointer.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!9 = !{}
!10 = !{!"clang version 13.0.0"}
!11 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 1, type: !13, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!12 = !DIFile(filename: "./src/test_pointer.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!13 = !DISubroutineType(types: !14)
!14 = !{!15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "n", scope: !11, file: !12, line: 3, type: !15)
!17 = !DILocation(line: 3, column: 9, scope: !11)
!18 = !DILocalVariable(name: "np", scope: !11, file: !12, line: 4, type: !19)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!20 = !DILocation(line: 4, column: 10, scope: !11)
!21 = !DILocalVariable(name: "npp", scope: !11, file: !12, line: 5, type: !22)
!22 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!23 = !DILocation(line: 5, column: 11, scope: !11)
!24 = !DILocalVariable(name: "rp", scope: !11, file: !12, line: 7, type: !19)
!25 = !DILocation(line: 7, column: 10, scope: !11)
!26 = !DILocation(line: 9, column: 8, scope: !11)
!27 = !DILocation(line: 9, column: 6, scope: !11)
!28 = !DILocation(line: 9, column: 13, scope: !11)
!29 = !DILocation(line: 10, column: 9, scope: !11)
!30 = !DILocation(line: 11, column: 8, scope: !11)
!31 = !DILocation(line: 11, column: 6, scope: !11)
!32 = !DILocation(line: 11, column: 13, scope: !11)
!33 = !DILocalVariable(name: "i", scope: !34, file: !12, line: 13, type: !15)
!34 = distinct !DILexicalBlock(scope: !11, file: !12, line: 13, column: 5)
!35 = !DILocation(line: 13, column: 15, scope: !34)
!36 = !DILocation(line: 13, column: 11, scope: !34)
!37 = !DILocation(line: 13, column: 22, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !12, line: 13, column: 5)
!39 = !DILocation(line: 13, column: 24, scope: !38)
!40 = !DILocation(line: 13, column: 5, scope: !34)
!41 = !DILocation(line: 14, column: 14, scope: !42)
!42 = distinct !DILexicalBlock(scope: !43, file: !12, line: 14, column: 14)
!43 = distinct !DILexicalBlock(scope: !38, file: !12, line: 13, column: 36)
!44 = !DILocation(line: 14, column: 16, scope: !42)
!45 = !DILocation(line: 14, column: 20, scope: !42)
!46 = !DILocation(line: 14, column: 14, scope: !43)
!47 = !DILocation(line: 15, column: 17, scope: !48)
!48 = distinct !DILexicalBlock(scope: !42, file: !12, line: 14, column: 27)
!49 = !DILocation(line: 16, column: 16, scope: !48)
!50 = !DILocation(line: 16, column: 14, scope: !48)
!51 = !DILocation(line: 16, column: 21, scope: !48)
!52 = !DILocation(line: 17, column: 9, scope: !48)
!53 = !DILocation(line: 19, column: 17, scope: !54)
!54 = distinct !DILexicalBlock(scope: !42, file: !12, line: 18, column: 14)
!55 = !DILocation(line: 20, column: 16, scope: !54)
!56 = !DILocation(line: 20, column: 14, scope: !54)
!57 = !DILocation(line: 20, column: 21, scope: !54)
!58 = !DILocation(line: 22, column: 5, scope: !43)
!59 = !DILocation(line: 13, column: 31, scope: !38)
!60 = !DILocation(line: 13, column: 5, scope: !38)
!61 = distinct !{!61, !40, !62, !63}
!62 = !DILocation(line: 22, column: 5, scope: !34)
!63 = !{!"llvm.loop.mustprogress"}
!64 = !DILocalVariable(name: "n1", scope: !11, file: !12, line: 24, type: !15)
!65 = !DILocation(line: 24, column: 9, scope: !11)
!66 = !DILocalVariable(name: "n2", scope: !11, file: !12, line: 24, type: !15)
!67 = !DILocation(line: 24, column: 17, scope: !11)
!68 = !DILocalVariable(name: "a", scope: !11, file: !12, line: 25, type: !22)
!69 = !DILocation(line: 25, column: 11, scope: !11)
!70 = !DILocation(line: 25, column: 15, scope: !11)
!71 = !DILocation(line: 26, column: 5, scope: !11)
!72 = !DILocation(line: 26, column: 10, scope: !11)
!73 = !DILocation(line: 27, column: 5, scope: !11)
!74 = !DILocation(line: 27, column: 10, scope: !11)
!75 = !DILocation(line: 28, column: 6, scope: !11)
!76 = !DILocation(line: 28, column: 11, scope: !11)
!77 = !DILocation(line: 29, column: 6, scope: !11)
!78 = !DILocation(line: 29, column: 11, scope: !11)
!79 = !DILocation(line: 44, column: 5, scope: !11)
