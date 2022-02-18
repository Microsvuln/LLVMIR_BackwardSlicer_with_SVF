; ModuleID = './test.cpp'
source_filename = "./test.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%class.A = type { i32* }

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_ZN1A3fooEPi(%class.A* nonnull align 8 dereferenceable(8) %this, i32* %a) #0 align 2 !dbg !10 {
entry:
  %this.addr = alloca %class.A*, align 8
  %a.addr = alloca i32*, align 8
  %foo_local = alloca i32*, align 8
  store %class.A* %this, %class.A** %this.addr, align 8
  call void @llvm.dbg.declare(metadata %class.A** %this.addr, metadata !22, metadata !DIExpression()), !dbg !24
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !25, metadata !DIExpression()), !dbg !26
  %this1 = load %class.A*, %class.A** %this.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %foo_local, metadata !27, metadata !DIExpression()), !dbg !28
  %0 = load i32*, i32** %a.addr, align 8, !dbg !29
  store i32* %0, i32** %foo_local, align 8, !dbg !28
  %1 = load i32*, i32** %foo_local, align 8, !dbg !30
  %2 = load i32, i32* %1, align 4, !dbg !31
  %mNumPtr = getelementptr inbounds %class.A, %class.A* %this1, i32 0, i32 0, !dbg !32
  %3 = load i32*, i32** %mNumPtr, align 8, !dbg !32
  store i32 %2, i32* %3, align 4, !dbg !33
  ret void, !dbg !34
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_ZN1A3barEPi(%class.A* nonnull align 8 dereferenceable(8) %this, i32* %a) #0 align 2 !dbg !35 {
entry:
  %this.addr = alloca %class.A*, align 8
  %a.addr = alloca i32*, align 8
  %foo_a = alloca i32*, align 8
  store %class.A* %this, %class.A** %this.addr, align 8
  call void @llvm.dbg.declare(metadata %class.A** %this.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !38, metadata !DIExpression()), !dbg !39
  %this1 = load %class.A*, %class.A** %this.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %foo_a, metadata !40, metadata !DIExpression()), !dbg !41
  %0 = load i32*, i32** %a.addr, align 8, !dbg !42
  store i32* %0, i32** %foo_a, align 8, !dbg !41
  %1 = load i32*, i32** %foo_a, align 8, !dbg !43
  call void @_ZN1A3fooEPi(%class.A* nonnull align 8 dereferenceable(8) %this1, i32* %1), !dbg !44
  ret void, !dbg !45
}

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #2 !dbg !46 {
entry:
  %retval = alloca i32, align 4
  %n = alloca i32, align 4
  %objA = alloca %class.A*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n, metadata !49, metadata !DIExpression()), !dbg !50
  store i32 2, i32* %n, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata %class.A** %objA, metadata !51, metadata !DIExpression()), !dbg !52
  %call = call noalias nonnull i8* @_Znwm(i64 8) #4, !dbg !53, !heapallocsite !12
  %0 = bitcast i8* %call to %class.A*, !dbg !53
  store %class.A* %0, %class.A** %objA, align 8, !dbg !52
  %1 = load %class.A*, %class.A** %objA, align 8, !dbg !54
  call void @_ZN1A3barEPi(%class.A* nonnull align 8 dereferenceable(8) %1, i32* %n), !dbg !55
  ret i32 0, !dbg !56
}

; Function Attrs: nobuiltin allocsize(0)
declare nonnull i8* @_Znwm(i64) #3

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #3 = { nobuiltin allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #4 = { builtin allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "Homebrew clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk", sdk: "MacOSX12.sdk")
!1 = !DIFile(filename: "test.cpp", directory: "/Users/ichang-yul/Desktop/svf-practice/test_class_in_heap")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Homebrew clang version 13.0.1"}
!10 = distinct !DISubprogram(name: "foo", linkageName: "_ZN1A3fooEPi", scope: !12, file: !11, line: 8, type: !18, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, declaration: !17, retainedNodes: !2)
!11 = !DIFile(filename: "./test.cpp", directory: "/Users/ichang-yul/Desktop/svf-practice/test_class_in_heap")
!12 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "A", file: !11, line: 1, size: 64, flags: DIFlagTypePassByValue, elements: !13, identifier: "_ZTS1A")
!13 = !{!14, !17, !21}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "mNumPtr", scope: !12, file: !11, line: 5, baseType: !15, size: 64, flags: DIFlagPublic)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!17 = !DISubprogram(name: "foo", linkageName: "_ZN1A3fooEPi", scope: !12, file: !11, line: 3, type: !18, scopeLine: 3, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!18 = !DISubroutineType(types: !19)
!19 = !{null, !20, !15}
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!21 = !DISubprogram(name: "bar", linkageName: "_ZN1A3barEPi", scope: !12, file: !11, line: 4, type: !18, scopeLine: 4, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!22 = !DILocalVariable(name: "this", arg: 1, scope: !10, type: !23, flags: DIFlagArtificial | DIFlagObjectPointer)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!24 = !DILocation(line: 0, scope: !10)
!25 = !DILocalVariable(name: "a", arg: 2, scope: !10, file: !11, line: 8, type: !15)
!26 = !DILocation(line: 8, column: 19, scope: !10)
!27 = !DILocalVariable(name: "foo_local", scope: !10, file: !11, line: 10, type: !15)
!28 = !DILocation(line: 10, column: 10, scope: !10)
!29 = !DILocation(line: 10, column: 22, scope: !10)
!30 = !DILocation(line: 11, column: 17, scope: !10)
!31 = !DILocation(line: 11, column: 16, scope: !10)
!32 = !DILocation(line: 11, column: 6, scope: !10)
!33 = !DILocation(line: 11, column: 14, scope: !10)
!34 = !DILocation(line: 12, column: 1, scope: !10)
!35 = distinct !DISubprogram(name: "bar", linkageName: "_ZN1A3barEPi", scope: !12, file: !11, line: 14, type: !18, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, declaration: !21, retainedNodes: !2)
!36 = !DILocalVariable(name: "this", arg: 1, scope: !35, type: !23, flags: DIFlagArtificial | DIFlagObjectPointer)
!37 = !DILocation(line: 0, scope: !35)
!38 = !DILocalVariable(name: "a", arg: 2, scope: !35, file: !11, line: 14, type: !15)
!39 = !DILocation(line: 14, column: 19, scope: !35)
!40 = !DILocalVariable(name: "foo_a", scope: !35, file: !11, line: 16, type: !15)
!41 = !DILocation(line: 16, column: 10, scope: !35)
!42 = !DILocation(line: 16, column: 18, scope: !35)
!43 = !DILocation(line: 17, column: 10, scope: !35)
!44 = !DILocation(line: 17, column: 5, scope: !35)
!45 = !DILocation(line: 18, column: 1, scope: !35)
!46 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 20, type: !47, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!47 = !DISubroutineType(types: !48)
!48 = !{!16}
!49 = !DILocalVariable(name: "n", scope: !46, file: !11, line: 22, type: !16)
!50 = !DILocation(line: 22, column: 9, scope: !46)
!51 = !DILocalVariable(name: "objA", scope: !46, file: !11, line: 23, type: !23)
!52 = !DILocation(line: 23, column: 8, scope: !46)
!53 = !DILocation(line: 23, column: 15, scope: !46)
!54 = !DILocation(line: 25, column: 5, scope: !46)
!55 = !DILocation(line: 25, column: 11, scope: !46)
!56 = !DILocation(line: 27, column: 5, scope: !46)
