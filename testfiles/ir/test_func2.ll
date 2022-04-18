; ModuleID = './src/test_func2.cpp'
source_filename = "./src/test_func2.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_Z4swapRiS_(i32* nonnull align 4 dereferenceable(4) %a, i32* nonnull align 4 dereferenceable(4) %b) #0 !dbg !10 {
entry:
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  %temp = alloca i32, align 4
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !16, metadata !DIExpression()), !dbg !17
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %temp, metadata !20, metadata !DIExpression()), !dbg !21
  %0 = load i32*, i32** %a.addr, align 8, !dbg !22
  %1 = load i32, i32* %0, align 4, !dbg !22
  store i32 %1, i32* %temp, align 4, !dbg !23
  %2 = load i32*, i32** %b.addr, align 8, !dbg !24
  %3 = load i32, i32* %2, align 4, !dbg !24
  %4 = load i32*, i32** %a.addr, align 8, !dbg !25
  store i32 %3, i32* %4, align 4, !dbg !26
  %5 = load i32, i32* %temp, align 4, !dbg !27
  %6 = load i32*, i32** %b.addr, align 8, !dbg !28
  store i32 %5, i32* %6, align 4, !dbg !29
  ret void, !dbg !30
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_Z3barv() #0 !dbg !31 {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 1, i32* %a, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata i32* %b, metadata !36, metadata !DIExpression()), !dbg !37
  store i32 2, i32* %b, align 4, !dbg !37
  call void @_Z4swapRiS_(i32* nonnull align 4 dereferenceable(4) %a, i32* nonnull align 4 dereferenceable(4) %b), !dbg !38
  ret void, !dbg !39
}

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !43, metadata !DIExpression()), !dbg !44
  store i32 1, i32* %a, align 4, !dbg !44
  call void @llvm.dbg.declare(metadata i32* %b, metadata !45, metadata !DIExpression()), !dbg !46
  store i32 2, i32* %b, align 4, !dbg !46
  call void @_Z3barv(), !dbg !47
  call void @_Z4swapRiS_(i32* nonnull align 4 dereferenceable(4) %a, i32* nonnull align 4 dereferenceable(4) %b), !dbg !48
  ret i32 0, !dbg !49
}

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_func2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "swap", linkageName: "_Z4swapRiS_", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_func2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14, !14}
!14 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!17 = !DILocation(line: 1, column: 17, scope: !10)
!18 = !DILocalVariable(name: "b", arg: 2, scope: !10, file: !11, line: 1, type: !14)
!19 = !DILocation(line: 1, column: 25, scope: !10)
!20 = !DILocalVariable(name: "temp", scope: !10, file: !11, line: 3, type: !15)
!21 = !DILocation(line: 3, column: 7, scope: !10)
!22 = !DILocation(line: 4, column: 10, scope: !10)
!23 = !DILocation(line: 4, column: 8, scope: !10)
!24 = !DILocation(line: 5, column: 7, scope: !10)
!25 = !DILocation(line: 5, column: 3, scope: !10)
!26 = !DILocation(line: 5, column: 5, scope: !10)
!27 = !DILocation(line: 6, column: 7, scope: !10)
!28 = !DILocation(line: 6, column: 3, scope: !10)
!29 = !DILocation(line: 6, column: 5, scope: !10)
!30 = !DILocation(line: 7, column: 1, scope: !10)
!31 = distinct !DISubprogram(name: "bar", linkageName: "_Z3barv", scope: !11, file: !11, line: 8, type: !32, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null}
!34 = !DILocalVariable(name: "a", scope: !31, file: !11, line: 9, type: !15)
!35 = !DILocation(line: 9, column: 7, scope: !31)
!36 = !DILocalVariable(name: "b", scope: !31, file: !11, line: 9, type: !15)
!37 = !DILocation(line: 9, column: 14, scope: !31)
!38 = !DILocation(line: 10, column: 3, scope: !31)
!39 = !DILocation(line: 11, column: 1, scope: !31)
!40 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 13, type: !41, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!15}
!43 = !DILocalVariable(name: "a", scope: !40, file: !11, line: 15, type: !15)
!44 = !DILocation(line: 15, column: 7, scope: !40)
!45 = !DILocalVariable(name: "b", scope: !40, file: !11, line: 15, type: !15)
!46 = !DILocation(line: 15, column: 14, scope: !40)
!47 = !DILocation(line: 16, column: 3, scope: !40)
!48 = !DILocation(line: 17, column: 3, scope: !40)
!49 = !DILocation(line: 18, column: 3, scope: !40)
