; ModuleID = 'src/test_class2.cpp'
source_filename = "src/test_class2.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.A = type { i32, i32, i32, i32, %class.B* }
%class.B = type { i32, i32, i32, i32 }
%class.D = type { %class.C, double }
%class.C = type { i32 }
%class.E = type { %class.C, i32, i32 }

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %a = alloca %class.A, align 8
  %pa = alloca %class.A*, align 8
  %objd = alloca %class.D*, align 8
  %obje = alloca %class.E*, align 8
  %pc = alloca %class.C*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %class.A* %a, metadata !13, metadata !DIExpression()), !dbg !28
  %mA1 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 0, !dbg !29
  store i32 1, i32* %mA1, align 8, !dbg !30
  %mA2 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 1, !dbg !31
  store i32 2, i32* %mA2, align 4, !dbg !32
  %mA3 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 2, !dbg !33
  store i32 3, i32* %mA3, align 8, !dbg !34
  %mA4 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 3, !dbg !35
  store i32 4, i32* %mA4, align 4, !dbg !36
  %call = call noalias nonnull i8* @_Znwm(i64 16) #3, !dbg !37, !heapallocsite !22
  %0 = bitcast i8* %call to %class.B*, !dbg !37
  %objB = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !38
  store %class.B* %0, %class.B** %objB, align 8, !dbg !39
  %objB1 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !40
  %1 = load %class.B*, %class.B** %objB1, align 8, !dbg !40
  %mB1 = getelementptr inbounds %class.B, %class.B* %1, i32 0, i32 0, !dbg !41
  store i32 5, i32* %mB1, align 4, !dbg !42
  %objB2 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !43
  %2 = load %class.B*, %class.B** %objB2, align 8, !dbg !43
  %mB2 = getelementptr inbounds %class.B, %class.B* %2, i32 0, i32 1, !dbg !44
  store i32 6, i32* %mB2, align 4, !dbg !45
  %objB3 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !46
  %3 = load %class.B*, %class.B** %objB3, align 8, !dbg !46
  %mB3 = getelementptr inbounds %class.B, %class.B* %3, i32 0, i32 2, !dbg !47
  store i32 7, i32* %mB3, align 4, !dbg !48
  %objB4 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !49
  %4 = load %class.B*, %class.B** %objB4, align 8, !dbg !49
  %mB4 = getelementptr inbounds %class.B, %class.B* %4, i32 0, i32 3, !dbg !50
  store i32 8, i32* %mB4, align 4, !dbg !51
  call void @llvm.dbg.declare(metadata %class.A** %pa, metadata !52, metadata !DIExpression()), !dbg !54
  %call5 = call noalias nonnull i8* @_Znwm(i64 24) #3, !dbg !55, !heapallocsite !14
  %5 = bitcast i8* %call5 to %class.A*, !dbg !55
  store %class.A* %5, %class.A** %pa, align 8, !dbg !54
  %6 = load %class.A*, %class.A** %pa, align 8, !dbg !56
  %mA16 = getelementptr inbounds %class.A, %class.A* %6, i32 0, i32 0, !dbg !57
  store i32 1, i32* %mA16, align 8, !dbg !58
  %7 = load %class.A*, %class.A** %pa, align 8, !dbg !59
  %mA27 = getelementptr inbounds %class.A, %class.A* %7, i32 0, i32 1, !dbg !60
  store i32 2, i32* %mA27, align 4, !dbg !61
  %8 = load %class.A*, %class.A** %pa, align 8, !dbg !62
  %mA38 = getelementptr inbounds %class.A, %class.A* %8, i32 0, i32 2, !dbg !63
  store i32 3, i32* %mA38, align 8, !dbg !64
  %9 = load %class.A*, %class.A** %pa, align 8, !dbg !65
  %mA49 = getelementptr inbounds %class.A, %class.A* %9, i32 0, i32 3, !dbg !66
  store i32 4, i32* %mA49, align 4, !dbg !67
  %call10 = call noalias nonnull i8* @_Znwm(i64 16) #3, !dbg !68, !heapallocsite !22
  %10 = bitcast i8* %call10 to %class.B*, !dbg !68
  %11 = load %class.A*, %class.A** %pa, align 8, !dbg !69
  %objB11 = getelementptr inbounds %class.A, %class.A* %11, i32 0, i32 4, !dbg !70
  store %class.B* %10, %class.B** %objB11, align 8, !dbg !71
  %12 = load %class.A*, %class.A** %pa, align 8, !dbg !72
  %objB12 = getelementptr inbounds %class.A, %class.A* %12, i32 0, i32 4, !dbg !73
  %13 = load %class.B*, %class.B** %objB12, align 8, !dbg !73
  %mB113 = getelementptr inbounds %class.B, %class.B* %13, i32 0, i32 0, !dbg !74
  store i32 5, i32* %mB113, align 4, !dbg !75
  %14 = load %class.A*, %class.A** %pa, align 8, !dbg !76
  %objB14 = getelementptr inbounds %class.A, %class.A* %14, i32 0, i32 4, !dbg !77
  %15 = load %class.B*, %class.B** %objB14, align 8, !dbg !77
  %mB215 = getelementptr inbounds %class.B, %class.B* %15, i32 0, i32 1, !dbg !78
  store i32 6, i32* %mB215, align 4, !dbg !79
  %16 = load %class.A*, %class.A** %pa, align 8, !dbg !80
  %objB16 = getelementptr inbounds %class.A, %class.A* %16, i32 0, i32 4, !dbg !81
  %17 = load %class.B*, %class.B** %objB16, align 8, !dbg !81
  %mB317 = getelementptr inbounds %class.B, %class.B* %17, i32 0, i32 2, !dbg !82
  store i32 7, i32* %mB317, align 4, !dbg !83
  %18 = load %class.A*, %class.A** %pa, align 8, !dbg !84
  %objB18 = getelementptr inbounds %class.A, %class.A* %18, i32 0, i32 4, !dbg !85
  %19 = load %class.B*, %class.B** %objB18, align 8, !dbg !85
  %mB419 = getelementptr inbounds %class.B, %class.B* %19, i32 0, i32 3, !dbg !86
  store i32 8, i32* %mB419, align 4, !dbg !87
  call void @llvm.dbg.declare(metadata %class.D** %objd, metadata !88, metadata !DIExpression()), !dbg !98
  %call20 = call noalias nonnull i8* @_Znwm(i64 16) #3, !dbg !99, !heapallocsite !90
  %20 = bitcast i8* %call20 to %class.D*, !dbg !99
  store %class.D* %20, %class.D** %objd, align 8, !dbg !98
  call void @llvm.dbg.declare(metadata %class.E** %obje, metadata !100, metadata !DIExpression()), !dbg !107
  %call21 = call noalias nonnull i8* @_Znwm(i64 12) #3, !dbg !108, !heapallocsite !102
  %21 = bitcast i8* %call21 to %class.E*, !dbg !108
  store %class.E* %21, %class.E** %obje, align 8, !dbg !107
  call void @llvm.dbg.declare(metadata %class.C** %pc, metadata !109, metadata !DIExpression()), !dbg !111
  %22 = load %class.D*, %class.D** %objd, align 8, !dbg !112
  %23 = bitcast %class.D* %22 to %class.C*, !dbg !112
  store %class.C* %23, %class.C** %pc, align 8, !dbg !111
  %24 = load %class.C*, %class.C** %pc, align 8, !dbg !113
  %c = getelementptr inbounds %class.C, %class.C* %24, i32 0, i32 0, !dbg !114
  store i32 1, i32* %c, align 4, !dbg !115
  %25 = load %class.E*, %class.E** %obje, align 8, !dbg !116
  %26 = bitcast %class.E* %25 to %class.C*, !dbg !116
  store %class.C* %26, %class.C** %pc, align 8, !dbg !117
  %27 = load %class.C*, %class.C** %pc, align 8, !dbg !118
  %c22 = getelementptr inbounds %class.C, %class.C* %27, i32 0, i32 0, !dbg !119
  store i32 2, i32* %c22, align 4, !dbg !120
  ret i32 0, !dbg !121
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nobuiltin allocsize(0)
declare dso_local nonnull i8* @_Znwm(i64) #2

attributes #0 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nobuiltin allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { builtin allocsize(0) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "src/test_class2.cpp", directory: "/home/lcy/LLVMIR_BackwardSlicer_with_SVF/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"uwtable", i32 1}
!7 = !{i32 7, !"frame-pointer", i32 2}
!8 = !{!"clang version 13.0.0"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 34, type: !10, scopeLine: 35, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 36, type: !14)
!14 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "A", file: !1, line: 9, size: 192, flags: DIFlagTypePassByValue, elements: !15, identifier: "_ZTS1A")
!15 = !{!16, !17, !18, !19, !20}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "mA1", scope: !14, file: !1, line: 11, baseType: !12, size: 32, flags: DIFlagPublic)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "mA2", scope: !14, file: !1, line: 12, baseType: !12, size: 32, offset: 32, flags: DIFlagPublic)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "mA3", scope: !14, file: !1, line: 13, baseType: !12, size: 32, offset: 64, flags: DIFlagPublic)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "mA4", scope: !14, file: !1, line: 14, baseType: !12, size: 32, offset: 96, flags: DIFlagPublic)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "objB", scope: !14, file: !1, line: 15, baseType: !21, size: 64, offset: 128, flags: DIFlagPublic)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !22, size: 64)
!22 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "B", file: !1, line: 1, size: 128, flags: DIFlagTypePassByValue, elements: !23, identifier: "_ZTS1B")
!23 = !{!24, !25, !26, !27}
!24 = !DIDerivedType(tag: DW_TAG_member, name: "mB1", scope: !22, file: !1, line: 3, baseType: !12, size: 32, flags: DIFlagPublic)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "mB2", scope: !22, file: !1, line: 4, baseType: !12, size: 32, offset: 32, flags: DIFlagPublic)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "mB3", scope: !22, file: !1, line: 5, baseType: !12, size: 32, offset: 64, flags: DIFlagPublic)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "mB4", scope: !22, file: !1, line: 6, baseType: !12, size: 32, offset: 96, flags: DIFlagPublic)
!28 = !DILocation(line: 36, column: 7, scope: !9)
!29 = !DILocation(line: 37, column: 7, scope: !9)
!30 = !DILocation(line: 37, column: 11, scope: !9)
!31 = !DILocation(line: 38, column: 7, scope: !9)
!32 = !DILocation(line: 38, column: 11, scope: !9)
!33 = !DILocation(line: 39, column: 7, scope: !9)
!34 = !DILocation(line: 39, column: 11, scope: !9)
!35 = !DILocation(line: 40, column: 7, scope: !9)
!36 = !DILocation(line: 40, column: 11, scope: !9)
!37 = !DILocation(line: 41, column: 14, scope: !9)
!38 = !DILocation(line: 41, column: 7, scope: !9)
!39 = !DILocation(line: 41, column: 12, scope: !9)
!40 = !DILocation(line: 43, column: 7, scope: !9)
!41 = !DILocation(line: 43, column: 13, scope: !9)
!42 = !DILocation(line: 43, column: 17, scope: !9)
!43 = !DILocation(line: 44, column: 7, scope: !9)
!44 = !DILocation(line: 44, column: 13, scope: !9)
!45 = !DILocation(line: 44, column: 17, scope: !9)
!46 = !DILocation(line: 45, column: 7, scope: !9)
!47 = !DILocation(line: 45, column: 13, scope: !9)
!48 = !DILocation(line: 45, column: 17, scope: !9)
!49 = !DILocation(line: 46, column: 7, scope: !9)
!50 = !DILocation(line: 46, column: 13, scope: !9)
!51 = !DILocation(line: 46, column: 17, scope: !9)
!52 = !DILocalVariable(name: "pa", scope: !9, file: !1, line: 48, type: !53)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!54 = !DILocation(line: 48, column: 8, scope: !9)
!55 = !DILocation(line: 48, column: 13, scope: !9)
!56 = !DILocation(line: 49, column: 5, scope: !9)
!57 = !DILocation(line: 49, column: 9, scope: !9)
!58 = !DILocation(line: 49, column: 13, scope: !9)
!59 = !DILocation(line: 50, column: 5, scope: !9)
!60 = !DILocation(line: 50, column: 9, scope: !9)
!61 = !DILocation(line: 50, column: 13, scope: !9)
!62 = !DILocation(line: 51, column: 5, scope: !9)
!63 = !DILocation(line: 51, column: 9, scope: !9)
!64 = !DILocation(line: 51, column: 13, scope: !9)
!65 = !DILocation(line: 52, column: 5, scope: !9)
!66 = !DILocation(line: 52, column: 9, scope: !9)
!67 = !DILocation(line: 52, column: 13, scope: !9)
!68 = !DILocation(line: 54, column: 16, scope: !9)
!69 = !DILocation(line: 54, column: 5, scope: !9)
!70 = !DILocation(line: 54, column: 9, scope: !9)
!71 = !DILocation(line: 54, column: 14, scope: !9)
!72 = !DILocation(line: 55, column: 5, scope: !9)
!73 = !DILocation(line: 55, column: 9, scope: !9)
!74 = !DILocation(line: 55, column: 15, scope: !9)
!75 = !DILocation(line: 55, column: 19, scope: !9)
!76 = !DILocation(line: 56, column: 5, scope: !9)
!77 = !DILocation(line: 56, column: 9, scope: !9)
!78 = !DILocation(line: 56, column: 15, scope: !9)
!79 = !DILocation(line: 56, column: 19, scope: !9)
!80 = !DILocation(line: 57, column: 5, scope: !9)
!81 = !DILocation(line: 57, column: 9, scope: !9)
!82 = !DILocation(line: 57, column: 15, scope: !9)
!83 = !DILocation(line: 57, column: 19, scope: !9)
!84 = !DILocation(line: 58, column: 5, scope: !9)
!85 = !DILocation(line: 58, column: 9, scope: !9)
!86 = !DILocation(line: 58, column: 15, scope: !9)
!87 = !DILocation(line: 58, column: 19, scope: !9)
!88 = !DILocalVariable(name: "objd", scope: !9, file: !1, line: 60, type: !89)
!89 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !90, size: 64)
!90 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "D", file: !1, line: 23, size: 128, flags: DIFlagTypePassByValue, elements: !91, identifier: "_ZTS1D")
!91 = !{!92, !96}
!92 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !90, baseType: !93, flags: DIFlagPublic, extraData: i32 0)
!93 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C", file: !1, line: 18, size: 32, flags: DIFlagTypePassByValue, elements: !94, identifier: "_ZTS1C")
!94 = !{!95}
!95 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !93, file: !1, line: 20, baseType: !12, size: 32, flags: DIFlagPublic)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !90, file: !1, line: 25, baseType: !97, size: 64, offset: 64, flags: DIFlagPublic)
!97 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!98 = !DILocation(line: 60, column: 8, scope: !9)
!99 = !DILocation(line: 60, column: 15, scope: !9)
!100 = !DILocalVariable(name: "obje", scope: !9, file: !1, line: 61, type: !101)
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!102 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "E", file: !1, line: 28, size: 96, flags: DIFlagTypePassByValue, elements: !103, identifier: "_ZTS1E")
!103 = !{!104, !105, !106}
!104 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !102, baseType: !93, flags: DIFlagPublic, extraData: i32 0)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !102, file: !1, line: 30, baseType: !12, size: 32, offset: 32, flags: DIFlagPublic)
!106 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !102, file: !1, line: 31, baseType: !12, size: 32, offset: 64, flags: DIFlagPublic)
!107 = !DILocation(line: 61, column: 8, scope: !9)
!108 = !DILocation(line: 61, column: 15, scope: !9)
!109 = !DILocalVariable(name: "pc", scope: !9, file: !1, line: 63, type: !110)
!110 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !93, size: 64)
!111 = !DILocation(line: 63, column: 8, scope: !9)
!112 = !DILocation(line: 63, column: 13, scope: !9)
!113 = !DILocation(line: 64, column: 5, scope: !9)
!114 = !DILocation(line: 64, column: 9, scope: !9)
!115 = !DILocation(line: 64, column: 11, scope: !9)
!116 = !DILocation(line: 66, column: 10, scope: !9)
!117 = !DILocation(line: 66, column: 8, scope: !9)
!118 = !DILocation(line: 67, column: 5, scope: !9)
!119 = !DILocation(line: 67, column: 9, scope: !9)
!120 = !DILocation(line: 67, column: 11, scope: !9)
!121 = !DILocation(line: 69, column: 5, scope: !9)
