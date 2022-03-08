; ModuleID = './src/test_func2.cpp'
source_filename = "./src/test_func2.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z4swapRiS_(i32* nonnull align 4 dereferenceable(4) %a, i32* nonnull align 4 dereferenceable(4) %b) #0 !dbg !11 {
entry:
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %temp = alloca i32, align 4
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %temp, metadata !21, metadata !DIExpression()), !dbg !22
  %0 = load i32*, i32** %a.addr, align 8, !dbg !23
  %1 = load i32, i32* %0, align 4, !dbg !23
  store i32 %1, i32* %temp, align 4, !dbg !24
  %2 = load i32*, i32** %b.addr, align 8, !dbg !25
  %3 = load i32, i32* %2, align 4, !dbg !25
  %4 = load i32*, i32** %a.addr, align 8, !dbg !26
  store i32 %3, i32* %4, align 4, !dbg !27
  %5 = load i32, i32* %temp, align 4, !dbg !28
  %6 = load i32*, i32** %b.addr, align 8, !dbg !29
  store i32 %5, i32* %6, align 4, !dbg !30
  ret i32 1, !dbg !31
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_Z3barv() #0 !dbg !32 {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !35, metadata !DIExpression()), !dbg !36
  store i32 1, i32* %a, align 4, !dbg !36
  call void @llvm.dbg.declare(metadata i32* %b, metadata !37, metadata !DIExpression()), !dbg !38
  store i32 2, i32* %b, align 4, !dbg !38
  %call = call i32 @_Z4swapRiS_(i32* nonnull align 4 dereferenceable(4) %a, i32* nonnull align 4 dereferenceable(4) %b), !dbg !39
  ret void, !dbg !40
}

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !41 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !44, metadata !DIExpression()), !dbg !45
  store i32 1, i32* %a, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata i32* %b, metadata !46, metadata !DIExpression()), !dbg !47
  store i32 2, i32* %b, align 4, !dbg !47
  call void @_Z3barv(), !dbg !48
  %call = call i32 @_Z4swapRiS_(i32* nonnull align 4 dereferenceable(4) %a, i32* nonnull align 4 dereferenceable(4) %b), !dbg !49
  ret i32 0, !dbg !50
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
!8 = !DIFile(filename: "src/test_func2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!9 = !{}
!10 = !{!"clang version 13.0.0"}
!11 = distinct !DISubprogram(name: "swap", linkageName: "_Z4swapRiS_", scope: !12, file: !12, line: 1, type: !13, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!12 = !DIFile(filename: "./src/test_func2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !16, !16}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !15, size: 64)
!17 = !DILocalVariable(name: "a", arg: 1, scope: !11, file: !12, line: 1, type: !16)
!18 = !DILocation(line: 1, column: 16, scope: !11)
!19 = !DILocalVariable(name: "b", arg: 2, scope: !11, file: !12, line: 1, type: !16)
!20 = !DILocation(line: 1, column: 24, scope: !11)
!21 = !DILocalVariable(name: "temp", scope: !11, file: !12, line: 3, type: !15)
!22 = !DILocation(line: 3, column: 7, scope: !11)
!23 = !DILocation(line: 4, column: 10, scope: !11)
!24 = !DILocation(line: 4, column: 8, scope: !11)
!25 = !DILocation(line: 5, column: 7, scope: !11)
!26 = !DILocation(line: 5, column: 3, scope: !11)
!27 = !DILocation(line: 5, column: 5, scope: !11)
!28 = !DILocation(line: 6, column: 7, scope: !11)
!29 = !DILocation(line: 6, column: 3, scope: !11)
!30 = !DILocation(line: 6, column: 5, scope: !11)
!31 = !DILocation(line: 7, column: 3, scope: !11)
!32 = distinct !DISubprogram(name: "bar", linkageName: "_Z3barv", scope: !12, file: !12, line: 9, type: !33, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!33 = !DISubroutineType(types: !34)
!34 = !{null}
!35 = !DILocalVariable(name: "a", scope: !32, file: !12, line: 10, type: !15)
!36 = !DILocation(line: 10, column: 7, scope: !32)
!37 = !DILocalVariable(name: "b", scope: !32, file: !12, line: 10, type: !15)
!38 = !DILocation(line: 10, column: 14, scope: !32)
!39 = !DILocation(line: 11, column: 3, scope: !32)
!40 = !DILocation(line: 12, column: 1, scope: !32)
!41 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 14, type: !42, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!42 = !DISubroutineType(types: !43)
!43 = !{!15}
!44 = !DILocalVariable(name: "a", scope: !41, file: !12, line: 16, type: !15)
!45 = !DILocation(line: 16, column: 7, scope: !41)
!46 = !DILocalVariable(name: "b", scope: !41, file: !12, line: 16, type: !15)
!47 = !DILocation(line: 16, column: 14, scope: !41)
!48 = !DILocation(line: 17, column: 3, scope: !41)
!49 = !DILocation(line: 18, column: 3, scope: !41)
!50 = !DILocation(line: 19, column: 3, scope: !41)
