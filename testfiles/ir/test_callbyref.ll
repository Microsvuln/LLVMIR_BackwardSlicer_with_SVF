; ModuleID = './src/test_callbyref.cpp'
source_filename = "./src/test_callbyref.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_Z3fooRiPi(i32* nonnull align 4 dereferenceable(4) %a, i32* %b) #0 !dbg !10 {
entry:
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !19, metadata !DIExpression()), !dbg !20
  %0 = load i32*, i32** %a.addr, align 8, !dbg !21
  %1 = load i32, i32* %0, align 4, !dbg !22
  %add = add nsw i32 %1, 3, !dbg !22
  store i32 %add, i32* %0, align 4, !dbg !22
  %2 = load i32*, i32** %b.addr, align 8, !dbg !23
  %3 = load i32, i32* %2, align 4, !dbg !24
  %add1 = add nsw i32 %3, 4, !dbg !24
  store i32 %add1, i32* %2, align 4, !dbg !24
  ret void, !dbg !25
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !26 {
entry:
  %retval = alloca i32, align 4
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n1, metadata !29, metadata !DIExpression()), !dbg !30
  store i32 1, i32* %n1, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata i32* %n2, metadata !31, metadata !DIExpression()), !dbg !32
  store i32 2, i32* %n2, align 4, !dbg !32
  call void @_Z3fooRiPi(i32* nonnull align 4 dereferenceable(4) %n1, i32* %n2), !dbg !33
  ret i32 0, !dbg !34
}

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_callbyref.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "foo", linkageName: "_Z3fooRiPi", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_callbyref.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14, !16}
!14 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!17 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!18 = !DILocation(line: 1, column: 16, scope: !10)
!19 = !DILocalVariable(name: "b", arg: 2, scope: !10, file: !11, line: 1, type: !16)
!20 = !DILocation(line: 1, column: 24, scope: !10)
!21 = !DILocation(line: 3, column: 5, scope: !10)
!22 = !DILocation(line: 3, column: 7, scope: !10)
!23 = !DILocation(line: 4, column: 6, scope: !10)
!24 = !DILocation(line: 4, column: 8, scope: !10)
!25 = !DILocation(line: 5, column: 1, scope: !10)
!26 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 7, type: !27, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!15}
!29 = !DILocalVariable(name: "n1", scope: !26, file: !11, line: 9, type: !15)
!30 = !DILocation(line: 9, column: 9, scope: !26)
!31 = !DILocalVariable(name: "n2", scope: !26, file: !11, line: 10, type: !15)
!32 = !DILocation(line: 10, column: 9, scope: !26)
!33 = !DILocation(line: 12, column: 5, scope: !26)
!34 = !DILocation(line: 14, column: 5, scope: !26)
