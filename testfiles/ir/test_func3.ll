; ModuleID = './src/test_func3.cpp'
source_filename = "./src/test_func3.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_Z3fooPiRi(i32* %fa, i32* nonnull align 4 dereferenceable(4) %fb) #0 !dbg !10 {
entry:
  %fa.addr = alloca i32*, align 8
  %fb.addr = alloca i32*, align 8
  %local = alloca i32, align 4
  store i32* %fa, i32** %fa.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %fa.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32* %fb, i32** %fb.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %fb.addr, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %local, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 10, i32* %local, align 4, !dbg !22
  %0 = load i32, i32* %local, align 4, !dbg !23
  %add = add nsw i32 %0, 1, !dbg !23
  store i32 %add, i32* %local, align 4, !dbg !23
  %1 = load i32*, i32** %fa.addr, align 8, !dbg !24
  %2 = load i32, i32* %1, align 4, !dbg !25
  %add1 = add nsw i32 %2, 1, !dbg !25
  store i32 %add1, i32* %1, align 4, !dbg !25
  %3 = load i32, i32* %local, align 4, !dbg !26
  %4 = load i32*, i32** %fa.addr, align 8, !dbg !27
  store i32 %3, i32* %4, align 4, !dbg !28
  %5 = load i32*, i32** %fa.addr, align 8, !dbg !29
  %6 = load i32, i32* %5, align 4, !dbg !30
  %7 = load i32, i32* %local, align 4, !dbg !31
  %add2 = add nsw i32 %6, %7, !dbg !32
  %8 = load i32*, i32** %fb.addr, align 8, !dbg !33
  store i32 %add2, i32* %8, align 4, !dbg !34
  ret void, !dbg !35
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !39, metadata !DIExpression()), !dbg !40
  store i32 1, i32* %a, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata i32* %b, metadata !41, metadata !DIExpression()), !dbg !42
  store i32 2, i32* %b, align 4, !dbg !42
  call void @_Z3fooPiRi(i32* %a, i32* nonnull align 4 dereferenceable(4) %b), !dbg !43
  ret i32 0, !dbg !44
}

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_func3.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "foo", linkageName: "_Z3fooPiRi", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_func3.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14, !16}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !15, size: 64)
!17 = !DILocalVariable(name: "fa", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!18 = !DILocation(line: 1, column: 16, scope: !10)
!19 = !DILocalVariable(name: "fb", arg: 2, scope: !10, file: !11, line: 1, type: !16)
!20 = !DILocation(line: 1, column: 25, scope: !10)
!21 = !DILocalVariable(name: "local", scope: !10, file: !11, line: 3, type: !15)
!22 = !DILocation(line: 3, column: 9, scope: !10)
!23 = !DILocation(line: 4, column: 11, scope: !10)
!24 = !DILocation(line: 5, column: 6, scope: !10)
!25 = !DILocation(line: 5, column: 9, scope: !10)
!26 = !DILocation(line: 6, column: 11, scope: !10)
!27 = !DILocation(line: 6, column: 6, scope: !10)
!28 = !DILocation(line: 6, column: 9, scope: !10)
!29 = !DILocation(line: 7, column: 11, scope: !10)
!30 = !DILocation(line: 7, column: 10, scope: !10)
!31 = !DILocation(line: 7, column: 16, scope: !10)
!32 = !DILocation(line: 7, column: 14, scope: !10)
!33 = !DILocation(line: 7, column: 5, scope: !10)
!34 = !DILocation(line: 7, column: 8, scope: !10)
!35 = !DILocation(line: 8, column: 1, scope: !10)
!36 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 10, type: !37, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{!15}
!39 = !DILocalVariable(name: "a", scope: !36, file: !11, line: 12, type: !15)
!40 = !DILocation(line: 12, column: 7, scope: !36)
!41 = !DILocalVariable(name: "b", scope: !36, file: !11, line: 12, type: !15)
!42 = !DILocation(line: 12, column: 14, scope: !36)
!43 = !DILocation(line: 13, column: 3, scope: !36)
!44 = !DILocation(line: 14, column: 3, scope: !36)
