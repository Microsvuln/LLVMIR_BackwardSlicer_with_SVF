; ModuleID = './src/test_class2.cpp'
source_filename = "./src/test_class2.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%class.A = type { i32, i32, i32, i32, %class.B* }
%class.B = type { i32, i32, i32, i32 }
%class.D = type { %class.C, double }
%class.C = type { i32 }
%class.E = type { %class.C, i32, i32 }

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %a = alloca %class.A, align 8
  %pa = alloca %class.A*, align 8
  %objd = alloca %class.D*, align 8
  %obje = alloca %class.E*, align 8
  %pc = alloca %class.C*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %class.A* %a, metadata !15, metadata !DIExpression()), !dbg !30
  %mA1 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 0, !dbg !31
  store i32 1, i32* %mA1, align 8, !dbg !32
  %mA2 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 1, !dbg !33
  store i32 2, i32* %mA2, align 4, !dbg !34
  %mA3 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 2, !dbg !35
  store i32 3, i32* %mA3, align 8, !dbg !36
  %mA4 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 3, !dbg !37
  store i32 4, i32* %mA4, align 4, !dbg !38
  %mA11 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 0, !dbg !39
  store i32 11, i32* %mA11, align 8, !dbg !40
  %mA22 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 1, !dbg !41
  store i32 22, i32* %mA22, align 4, !dbg !42
  %mA33 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 2, !dbg !43
  store i32 33, i32* %mA33, align 8, !dbg !44
  %mA44 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 3, !dbg !45
  store i32 44, i32* %mA44, align 4, !dbg !46
  %call = call noalias nonnull i8* @_Znwm(i64 16) #3, !dbg !47, !heapallocsite !24
  %0 = bitcast i8* %call to %class.B*, !dbg !47
  %objB = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !48
  store %class.B* %0, %class.B** %objB, align 8, !dbg !49
  %objB5 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !50
  %1 = load %class.B*, %class.B** %objB5, align 8, !dbg !50
  %mB1 = getelementptr inbounds %class.B, %class.B* %1, i32 0, i32 0, !dbg !51
  store i32 5, i32* %mB1, align 4, !dbg !52
  %objB6 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !53
  %2 = load %class.B*, %class.B** %objB6, align 8, !dbg !53
  %mB2 = getelementptr inbounds %class.B, %class.B* %2, i32 0, i32 1, !dbg !54
  store i32 6, i32* %mB2, align 4, !dbg !55
  %objB7 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !56
  %3 = load %class.B*, %class.B** %objB7, align 8, !dbg !56
  %mB3 = getelementptr inbounds %class.B, %class.B* %3, i32 0, i32 2, !dbg !57
  store i32 7, i32* %mB3, align 4, !dbg !58
  %objB8 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !59
  %4 = load %class.B*, %class.B** %objB8, align 8, !dbg !59
  %mB4 = getelementptr inbounds %class.B, %class.B* %4, i32 0, i32 3, !dbg !60
  store i32 8, i32* %mB4, align 4, !dbg !61
  %objB9 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !62
  %5 = load %class.B*, %class.B** %objB9, align 8, !dbg !62
  %mB110 = getelementptr inbounds %class.B, %class.B* %5, i32 0, i32 0, !dbg !63
  store i32 9, i32* %mB110, align 4, !dbg !64
  %objB11 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !65
  %6 = load %class.B*, %class.B** %objB11, align 8, !dbg !65
  %mB212 = getelementptr inbounds %class.B, %class.B* %6, i32 0, i32 1, !dbg !66
  store i32 10, i32* %mB212, align 4, !dbg !67
  %objB13 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !68
  %7 = load %class.B*, %class.B** %objB13, align 8, !dbg !68
  %mB314 = getelementptr inbounds %class.B, %class.B* %7, i32 0, i32 2, !dbg !69
  store i32 11, i32* %mB314, align 4, !dbg !70
  %objB15 = getelementptr inbounds %class.A, %class.A* %a, i32 0, i32 4, !dbg !71
  %8 = load %class.B*, %class.B** %objB15, align 8, !dbg !71
  %mB416 = getelementptr inbounds %class.B, %class.B* %8, i32 0, i32 3, !dbg !72
  store i32 12, i32* %mB416, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata %class.A** %pa, metadata !74, metadata !DIExpression()), !dbg !76
  %call17 = call noalias nonnull i8* @_Znwm(i64 24) #3, !dbg !77, !heapallocsite !16
  %9 = bitcast i8* %call17 to %class.A*, !dbg !77
  store %class.A* %9, %class.A** %pa, align 8, !dbg !76
  %10 = load %class.A*, %class.A** %pa, align 8, !dbg !78
  %mA118 = getelementptr inbounds %class.A, %class.A* %10, i32 0, i32 0, !dbg !79
  store i32 1, i32* %mA118, align 8, !dbg !80
  %11 = load %class.A*, %class.A** %pa, align 8, !dbg !81
  %mA219 = getelementptr inbounds %class.A, %class.A* %11, i32 0, i32 1, !dbg !82
  store i32 2, i32* %mA219, align 4, !dbg !83
  %12 = load %class.A*, %class.A** %pa, align 8, !dbg !84
  %mA320 = getelementptr inbounds %class.A, %class.A* %12, i32 0, i32 2, !dbg !85
  store i32 3, i32* %mA320, align 8, !dbg !86
  %13 = load %class.A*, %class.A** %pa, align 8, !dbg !87
  %mA421 = getelementptr inbounds %class.A, %class.A* %13, i32 0, i32 3, !dbg !88
  store i32 4, i32* %mA421, align 4, !dbg !89
  %call22 = call noalias nonnull i8* @_Znwm(i64 16) #3, !dbg !90, !heapallocsite !24
  %14 = bitcast i8* %call22 to %class.B*, !dbg !90
  %15 = load %class.A*, %class.A** %pa, align 8, !dbg !91
  %objB23 = getelementptr inbounds %class.A, %class.A* %15, i32 0, i32 4, !dbg !92
  store %class.B* %14, %class.B** %objB23, align 8, !dbg !93
  %16 = load %class.A*, %class.A** %pa, align 8, !dbg !94
  %objB24 = getelementptr inbounds %class.A, %class.A* %16, i32 0, i32 4, !dbg !95
  %17 = load %class.B*, %class.B** %objB24, align 8, !dbg !95
  %mB125 = getelementptr inbounds %class.B, %class.B* %17, i32 0, i32 0, !dbg !96
  store i32 5, i32* %mB125, align 4, !dbg !97
  %18 = load %class.A*, %class.A** %pa, align 8, !dbg !98
  %objB26 = getelementptr inbounds %class.A, %class.A* %18, i32 0, i32 4, !dbg !99
  %19 = load %class.B*, %class.B** %objB26, align 8, !dbg !99
  %mB227 = getelementptr inbounds %class.B, %class.B* %19, i32 0, i32 1, !dbg !100
  store i32 6, i32* %mB227, align 4, !dbg !101
  %20 = load %class.A*, %class.A** %pa, align 8, !dbg !102
  %objB28 = getelementptr inbounds %class.A, %class.A* %20, i32 0, i32 4, !dbg !103
  %21 = load %class.B*, %class.B** %objB28, align 8, !dbg !103
  %mB329 = getelementptr inbounds %class.B, %class.B* %21, i32 0, i32 2, !dbg !104
  store i32 7, i32* %mB329, align 4, !dbg !105
  %22 = load %class.A*, %class.A** %pa, align 8, !dbg !106
  %objB30 = getelementptr inbounds %class.A, %class.A* %22, i32 0, i32 4, !dbg !107
  %23 = load %class.B*, %class.B** %objB30, align 8, !dbg !107
  %mB431 = getelementptr inbounds %class.B, %class.B* %23, i32 0, i32 3, !dbg !108
  store i32 8, i32* %mB431, align 4, !dbg !109
  call void @llvm.dbg.declare(metadata %class.D** %objd, metadata !110, metadata !DIExpression()), !dbg !120
  %call32 = call noalias nonnull i8* @_Znwm(i64 16) #3, !dbg !121, !heapallocsite !112
  %24 = bitcast i8* %call32 to %class.D*, !dbg !121
  store %class.D* %24, %class.D** %objd, align 8, !dbg !120
  call void @llvm.dbg.declare(metadata %class.E** %obje, metadata !122, metadata !DIExpression()), !dbg !129
  %call33 = call noalias nonnull i8* @_Znwm(i64 12) #3, !dbg !130, !heapallocsite !124
  %25 = bitcast i8* %call33 to %class.E*, !dbg !130
  store %class.E* %25, %class.E** %obje, align 8, !dbg !129
  call void @llvm.dbg.declare(metadata %class.C** %pc, metadata !131, metadata !DIExpression()), !dbg !133
  %26 = load %class.D*, %class.D** %objd, align 8, !dbg !134
  %27 = bitcast %class.D* %26 to %class.C*, !dbg !134
  store %class.C* %27, %class.C** %pc, align 8, !dbg !133
  %28 = load %class.C*, %class.C** %pc, align 8, !dbg !135
  %c = getelementptr inbounds %class.C, %class.C* %28, i32 0, i32 0, !dbg !136
  store i32 1, i32* %c, align 4, !dbg !137
  %29 = load %class.E*, %class.E** %obje, align 8, !dbg !138
  %30 = bitcast %class.E* %29 to %class.C*, !dbg !138
  store %class.C* %30, %class.C** %pc, align 8, !dbg !139
  %31 = load %class.C*, %class.C** %pc, align 8, !dbg !140
  %c34 = getelementptr inbounds %class.C, %class.C* %31, i32 0, i32 0, !dbg !141
  store i32 2, i32* %c34, align 4, !dbg !142
  ret i32 0, !dbg !143
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

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_class2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 34, type: !12, scopeLine: 35, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_class2.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "a", scope: !10, file: !11, line: 36, type: !16)
!16 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "A", file: !11, line: 9, size: 192, flags: DIFlagTypePassByValue, elements: !17, identifier: "_ZTS1A")
!17 = !{!18, !19, !20, !21, !22}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "mA1", scope: !16, file: !11, line: 11, baseType: !14, size: 32, flags: DIFlagPublic)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "mA2", scope: !16, file: !11, line: 12, baseType: !14, size: 32, offset: 32, flags: DIFlagPublic)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "mA3", scope: !16, file: !11, line: 13, baseType: !14, size: 32, offset: 64, flags: DIFlagPublic)
!21 = !DIDerivedType(tag: DW_TAG_member, name: "mA4", scope: !16, file: !11, line: 14, baseType: !14, size: 32, offset: 96, flags: DIFlagPublic)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "objB", scope: !16, file: !11, line: 15, baseType: !23, size: 64, offset: 128, flags: DIFlagPublic)
!23 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!24 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "B", file: !11, line: 1, size: 128, flags: DIFlagTypePassByValue, elements: !25, identifier: "_ZTS1B")
!25 = !{!26, !27, !28, !29}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "mB1", scope: !24, file: !11, line: 3, baseType: !14, size: 32, flags: DIFlagPublic)
!27 = !DIDerivedType(tag: DW_TAG_member, name: "mB2", scope: !24, file: !11, line: 4, baseType: !14, size: 32, offset: 32, flags: DIFlagPublic)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "mB3", scope: !24, file: !11, line: 5, baseType: !14, size: 32, offset: 64, flags: DIFlagPublic)
!29 = !DIDerivedType(tag: DW_TAG_member, name: "mB4", scope: !24, file: !11, line: 6, baseType: !14, size: 32, offset: 96, flags: DIFlagPublic)
!30 = !DILocation(line: 36, column: 7, scope: !10)
!31 = !DILocation(line: 37, column: 7, scope: !10)
!32 = !DILocation(line: 37, column: 11, scope: !10)
!33 = !DILocation(line: 38, column: 7, scope: !10)
!34 = !DILocation(line: 38, column: 11, scope: !10)
!35 = !DILocation(line: 39, column: 7, scope: !10)
!36 = !DILocation(line: 39, column: 11, scope: !10)
!37 = !DILocation(line: 40, column: 7, scope: !10)
!38 = !DILocation(line: 40, column: 11, scope: !10)
!39 = !DILocation(line: 41, column: 7, scope: !10)
!40 = !DILocation(line: 41, column: 11, scope: !10)
!41 = !DILocation(line: 42, column: 7, scope: !10)
!42 = !DILocation(line: 42, column: 11, scope: !10)
!43 = !DILocation(line: 43, column: 7, scope: !10)
!44 = !DILocation(line: 43, column: 11, scope: !10)
!45 = !DILocation(line: 44, column: 7, scope: !10)
!46 = !DILocation(line: 44, column: 11, scope: !10)
!47 = !DILocation(line: 45, column: 14, scope: !10)
!48 = !DILocation(line: 45, column: 7, scope: !10)
!49 = !DILocation(line: 45, column: 12, scope: !10)
!50 = !DILocation(line: 47, column: 7, scope: !10)
!51 = !DILocation(line: 47, column: 13, scope: !10)
!52 = !DILocation(line: 47, column: 17, scope: !10)
!53 = !DILocation(line: 48, column: 7, scope: !10)
!54 = !DILocation(line: 48, column: 13, scope: !10)
!55 = !DILocation(line: 48, column: 17, scope: !10)
!56 = !DILocation(line: 49, column: 7, scope: !10)
!57 = !DILocation(line: 49, column: 13, scope: !10)
!58 = !DILocation(line: 49, column: 17, scope: !10)
!59 = !DILocation(line: 50, column: 7, scope: !10)
!60 = !DILocation(line: 50, column: 13, scope: !10)
!61 = !DILocation(line: 50, column: 17, scope: !10)
!62 = !DILocation(line: 51, column: 7, scope: !10)
!63 = !DILocation(line: 51, column: 13, scope: !10)
!64 = !DILocation(line: 51, column: 17, scope: !10)
!65 = !DILocation(line: 52, column: 7, scope: !10)
!66 = !DILocation(line: 52, column: 13, scope: !10)
!67 = !DILocation(line: 52, column: 17, scope: !10)
!68 = !DILocation(line: 53, column: 7, scope: !10)
!69 = !DILocation(line: 53, column: 13, scope: !10)
!70 = !DILocation(line: 53, column: 17, scope: !10)
!71 = !DILocation(line: 54, column: 7, scope: !10)
!72 = !DILocation(line: 54, column: 13, scope: !10)
!73 = !DILocation(line: 54, column: 17, scope: !10)
!74 = !DILocalVariable(name: "pa", scope: !10, file: !11, line: 56, type: !75)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!76 = !DILocation(line: 56, column: 8, scope: !10)
!77 = !DILocation(line: 56, column: 13, scope: !10)
!78 = !DILocation(line: 57, column: 5, scope: !10)
!79 = !DILocation(line: 57, column: 9, scope: !10)
!80 = !DILocation(line: 57, column: 13, scope: !10)
!81 = !DILocation(line: 58, column: 5, scope: !10)
!82 = !DILocation(line: 58, column: 9, scope: !10)
!83 = !DILocation(line: 58, column: 13, scope: !10)
!84 = !DILocation(line: 59, column: 5, scope: !10)
!85 = !DILocation(line: 59, column: 9, scope: !10)
!86 = !DILocation(line: 59, column: 13, scope: !10)
!87 = !DILocation(line: 60, column: 5, scope: !10)
!88 = !DILocation(line: 60, column: 9, scope: !10)
!89 = !DILocation(line: 60, column: 13, scope: !10)
!90 = !DILocation(line: 62, column: 16, scope: !10)
!91 = !DILocation(line: 62, column: 5, scope: !10)
!92 = !DILocation(line: 62, column: 9, scope: !10)
!93 = !DILocation(line: 62, column: 14, scope: !10)
!94 = !DILocation(line: 63, column: 5, scope: !10)
!95 = !DILocation(line: 63, column: 9, scope: !10)
!96 = !DILocation(line: 63, column: 15, scope: !10)
!97 = !DILocation(line: 63, column: 19, scope: !10)
!98 = !DILocation(line: 64, column: 5, scope: !10)
!99 = !DILocation(line: 64, column: 9, scope: !10)
!100 = !DILocation(line: 64, column: 15, scope: !10)
!101 = !DILocation(line: 64, column: 19, scope: !10)
!102 = !DILocation(line: 65, column: 5, scope: !10)
!103 = !DILocation(line: 65, column: 9, scope: !10)
!104 = !DILocation(line: 65, column: 15, scope: !10)
!105 = !DILocation(line: 65, column: 19, scope: !10)
!106 = !DILocation(line: 66, column: 5, scope: !10)
!107 = !DILocation(line: 66, column: 9, scope: !10)
!108 = !DILocation(line: 66, column: 15, scope: !10)
!109 = !DILocation(line: 66, column: 19, scope: !10)
!110 = !DILocalVariable(name: "objd", scope: !10, file: !11, line: 68, type: !111)
!111 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !112, size: 64)
!112 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "D", file: !11, line: 23, size: 128, flags: DIFlagTypePassByValue, elements: !113, identifier: "_ZTS1D")
!113 = !{!114, !118}
!114 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !112, baseType: !115, flags: DIFlagPublic, extraData: i32 0)
!115 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "C", file: !11, line: 18, size: 32, flags: DIFlagTypePassByValue, elements: !116, identifier: "_ZTS1C")
!116 = !{!117}
!117 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !115, file: !11, line: 20, baseType: !14, size: 32, flags: DIFlagPublic)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !112, file: !11, line: 25, baseType: !119, size: 64, offset: 64, flags: DIFlagPublic)
!119 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!120 = !DILocation(line: 68, column: 8, scope: !10)
!121 = !DILocation(line: 68, column: 15, scope: !10)
!122 = !DILocalVariable(name: "obje", scope: !10, file: !11, line: 69, type: !123)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "E", file: !11, line: 28, size: 96, flags: DIFlagTypePassByValue, elements: !125, identifier: "_ZTS1E")
!125 = !{!126, !127, !128}
!126 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !124, baseType: !115, flags: DIFlagPublic, extraData: i32 0)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "i1", scope: !124, file: !11, line: 30, baseType: !14, size: 32, offset: 32, flags: DIFlagPublic)
!128 = !DIDerivedType(tag: DW_TAG_member, name: "i2", scope: !124, file: !11, line: 31, baseType: !14, size: 32, offset: 64, flags: DIFlagPublic)
!129 = !DILocation(line: 69, column: 8, scope: !10)
!130 = !DILocation(line: 69, column: 15, scope: !10)
!131 = !DILocalVariable(name: "pc", scope: !10, file: !11, line: 71, type: !132)
!132 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!133 = !DILocation(line: 71, column: 8, scope: !10)
!134 = !DILocation(line: 71, column: 13, scope: !10)
!135 = !DILocation(line: 72, column: 5, scope: !10)
!136 = !DILocation(line: 72, column: 9, scope: !10)
!137 = !DILocation(line: 72, column: 11, scope: !10)
!138 = !DILocation(line: 74, column: 10, scope: !10)
!139 = !DILocation(line: 74, column: 8, scope: !10)
!140 = !DILocation(line: 75, column: 5, scope: !10)
!141 = !DILocation(line: 75, column: 9, scope: !10)
!142 = !DILocation(line: 75, column: 11, scope: !10)
!143 = !DILocation(line: 77, column: 5, scope: !10)
