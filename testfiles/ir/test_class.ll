; ModuleID = './src/test_class.cpp'
source_filename = "./src/test_class.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%class.A = type { i32 }

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %objA = alloca %class.A*, align 8
  %objB = alloca %class.A*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 2, i32* %n, align 4, !dbg !16
  call void @llvm.dbg.declare(metadata %class.A** %objA, metadata !17, metadata !DIExpression()), !dbg !22
  %call = call noalias nonnull i8* @_Znwm(i64 4) #3, !dbg !23, !heapallocsite !19
  %0 = bitcast i8* %call to %class.A*, !dbg !23
  store %class.A* %0, %class.A** %objA, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata %class.A** %objB, metadata !24, metadata !DIExpression()), !dbg !25
  %call1 = call noalias nonnull i8* @_Znwm(i64 4) #3, !dbg !26, !heapallocsite !19
  %1 = bitcast i8* %call1 to %class.A*, !dbg !26
  store %class.A* %1, %class.A** %objB, align 8, !dbg !25
  %2 = load %class.A*, %class.A** %objA, align 8, !dbg !27
  %mNumPtr = getelementptr inbounds %class.A, %class.A* %2, i32 0, i32 0, !dbg !28
  store i32 2, i32* %mNumPtr, align 4, !dbg !29
  %3 = load i32, i32* %n, align 4, !dbg !30
  %4 = load %class.A*, %class.A** %objA, align 8, !dbg !31
  %mNumPtr2 = getelementptr inbounds %class.A, %class.A* %4, i32 0, i32 0, !dbg !32
  %5 = load i32, i32* %mNumPtr2, align 4, !dbg !33
  %add = add nsw i32 %5, %3, !dbg !33
  store i32 %add, i32* %mNumPtr2, align 4, !dbg !33
  %6 = load %class.A*, %class.A** %objB, align 8, !dbg !34
  %mNumPtr3 = getelementptr inbounds %class.A, %class.A* %6, i32 0, i32 0, !dbg !35
  store i32 2, i32* %mNumPtr3, align 4, !dbg !36
  %7 = load i32, i32* %n, align 4, !dbg !37
  %8 = load %class.A*, %class.A** %objB, align 8, !dbg !38
  %mNumPtr4 = getelementptr inbounds %class.A, %class.A* %8, i32 0, i32 0, !dbg !39
  %9 = load i32, i32* %mNumPtr4, align 4, !dbg !40
  %add5 = add nsw i32 %9, %7, !dbg !40
  store i32 %add5, i32* %mNumPtr4, align 4, !dbg !40
  ret i32 0, !dbg !41
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nobuiltin allocsize(0)
declare nonnull i8* @_Znwm(i64) #2

attributes #0 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nobuiltin allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #3 = { builtin allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "Homebrew clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk", sdk: "MacOSX12.sdk")
!1 = !DIFile(filename: "src/test_class.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Homebrew clang version 13.0.1"}
!10 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 6, type: !12, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_class.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "n", scope: !10, file: !11, line: 8, type: !14)
!16 = !DILocation(line: 8, column: 9, scope: !10)
!17 = !DILocalVariable(name: "objA", scope: !10, file: !11, line: 9, type: !18)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "A", file: !11, line: 1, size: 32, flags: DIFlagTypePassByValue, elements: !20, identifier: "_ZTS1A")
!20 = !{!21}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "mNumPtr", scope: !19, file: !11, line: 3, baseType: !14, size: 32, flags: DIFlagPublic)
!22 = !DILocation(line: 9, column: 8, scope: !10)
!23 = !DILocation(line: 9, column: 15, scope: !10)
!24 = !DILocalVariable(name: "objB", scope: !10, file: !11, line: 10, type: !18)
!25 = !DILocation(line: 10, column: 8, scope: !10)
!26 = !DILocation(line: 10, column: 15, scope: !10)
!27 = !DILocation(line: 12, column: 5, scope: !10)
!28 = !DILocation(line: 12, column: 11, scope: !10)
!29 = !DILocation(line: 12, column: 19, scope: !10)
!30 = !DILocation(line: 13, column: 22, scope: !10)
!31 = !DILocation(line: 13, column: 5, scope: !10)
!32 = !DILocation(line: 13, column: 11, scope: !10)
!33 = !DILocation(line: 13, column: 19, scope: !10)
!34 = !DILocation(line: 14, column: 5, scope: !10)
!35 = !DILocation(line: 14, column: 11, scope: !10)
!36 = !DILocation(line: 14, column: 19, scope: !10)
!37 = !DILocation(line: 15, column: 22, scope: !10)
!38 = !DILocation(line: 15, column: 5, scope: !10)
!39 = !DILocation(line: 15, column: 11, scope: !10)
!40 = !DILocation(line: 15, column: 19, scope: !10)
!41 = !DILocation(line: 17, column: 5, scope: !10)
