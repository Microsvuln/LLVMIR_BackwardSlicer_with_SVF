; ModuleID = './src/test_func_params.cpp'
source_filename = "./src/test_func_params.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

%struct.structA = type { i32, double, i32*, double*, %struct.structA* }

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z7integeriRiPi(i32 %a, i32* nonnull align 4 dereferenceable(4) %b, i32* %c) #0 !dbg !11 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32*, align 8
  %c.addr = alloca i32*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !18, metadata !DIExpression()), !dbg !19
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i32* %c, i32** %c.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %c.addr, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load i32, i32* %a.addr, align 4, !dbg !24
  %1 = load i32*, i32** %b.addr, align 8, !dbg !25
  %2 = load i32, i32* %1, align 4, !dbg !25
  %add = add nsw i32 %0, %2, !dbg !26
  %3 = load i32*, i32** %c.addr, align 8, !dbg !27
  %4 = load i32, i32* %3, align 4, !dbg !28
  %add1 = add nsw i32 %add, %4, !dbg !29
  ret i32 %add1, !dbg !30
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define double @_Z8floatingdRdPd(double %a, double* nonnull align 8 dereferenceable(8) %b, double* %c) #0 !dbg !31 {
entry:
  %a.addr = alloca double, align 8
  %b.addr = alloca double*, align 8
  %c.addr = alloca double*, align 8
  store double %a, double* %a.addr, align 8
  call void @llvm.dbg.declare(metadata double* %a.addr, metadata !37, metadata !DIExpression()), !dbg !38
  store double* %b, double** %b.addr, align 8
  call void @llvm.dbg.declare(metadata double** %b.addr, metadata !39, metadata !DIExpression()), !dbg !40
  store double* %c, double** %c.addr, align 8
  call void @llvm.dbg.declare(metadata double** %c.addr, metadata !41, metadata !DIExpression()), !dbg !42
  %0 = load double, double* %a.addr, align 8, !dbg !43
  %1 = load double*, double** %b.addr, align 8, !dbg !44
  %2 = load double, double* %1, align 8, !dbg !44
  %add = fadd double %0, %2, !dbg !45
  %3 = load double*, double** %c.addr, align 8, !dbg !46
  %4 = load double, double* %3, align 8, !dbg !47
  %add1 = fadd double %add, %4, !dbg !48
  ret double %add1, !dbg !49
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define void @_Z9structure7structARS_PS_(%struct.structA* byval(%struct.structA) align 8 %a, %struct.structA* nonnull align 8 dereferenceable(40) %b, %struct.structA* %c) #0 !dbg !50 {
entry:
  %b.addr = alloca %struct.structA*, align 8
  %c.addr = alloca %struct.structA*, align 8
  call void @llvm.dbg.declare(metadata %struct.structA* %a, metadata !62, metadata !DIExpression()), !dbg !63
  store %struct.structA* %b, %struct.structA** %b.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.structA** %b.addr, metadata !64, metadata !DIExpression()), !dbg !65
  store %struct.structA* %c, %struct.structA** %c.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.structA** %c.addr, metadata !66, metadata !DIExpression()), !dbg !67
  ret void, !dbg !68
}

; Function Attrs: mustprogress noinline norecurse nounwind optnone ssp uwtable
define i32 @main() #2 !dbg !69 {
entry:
  %retval = alloca i32, align 4
  %local = alloca i32, align 4
  %f = alloca double, align 8
  %s = alloca %struct.structA, align 8
  %agg.tmp = alloca %struct.structA, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %local, metadata !72, metadata !DIExpression()), !dbg !73
  store i32 1, i32* %local, align 4, !dbg !73
  call void @llvm.dbg.declare(metadata double* %f, metadata !74, metadata !DIExpression()), !dbg !75
  store double 1.000000e+00, double* %f, align 8, !dbg !75
  call void @llvm.dbg.declare(metadata %struct.structA* %s, metadata !76, metadata !DIExpression()), !dbg !77
  %0 = load i32, i32* %local, align 4, !dbg !78
  %call = call i32 @_Z7integeriRiPi(i32 %0, i32* nonnull align 4 dereferenceable(4) %local, i32* %local), !dbg !79
  store i32 %call, i32* %local, align 4, !dbg !80
  %1 = load double, double* %f, align 8, !dbg !81
  %call1 = call double @_Z8floatingdRdPd(double %1, double* nonnull align 8 dereferenceable(8) %f, double* %f), !dbg !82
  store double %call1, double* %f, align 8, !dbg !83
  %2 = bitcast %struct.structA* %agg.tmp to i8*, !dbg !84
  %3 = bitcast %struct.structA* %s to i8*, !dbg !84
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %2, i8* align 8 %3, i64 40, i1 false), !dbg !84
  call void @_Z9structure7structARS_PS_(%struct.structA* byval(%struct.structA) align 8 %agg.tmp, %struct.structA* nonnull align 8 dereferenceable(40) %s, %struct.structA* %s), !dbg !85
  ret i32 0, !dbg !86
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #3 = { argmemonly nofree nounwind willreturn }

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
!8 = !DIFile(filename: "src/test_func_params.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!9 = !{}
!10 = !{!"clang version 13.0.0"}
!11 = distinct !DISubprogram(name: "integer", linkageName: "_Z7integeriRiPi", scope: !12, file: !12, line: 9, type: !13, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!12 = !DIFile(filename: "./src/test_func_params.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15, !16, !17}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !15, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!18 = !DILocalVariable(name: "a", arg: 1, scope: !11, file: !12, line: 9, type: !15)
!19 = !DILocation(line: 9, column: 18, scope: !11)
!20 = !DILocalVariable(name: "b", arg: 2, scope: !11, file: !12, line: 9, type: !16)
!21 = !DILocation(line: 9, column: 26, scope: !11)
!22 = !DILocalVariable(name: "c", arg: 3, scope: !11, file: !12, line: 9, type: !17)
!23 = !DILocation(line: 9, column: 34, scope: !11)
!24 = !DILocation(line: 11, column: 12, scope: !11)
!25 = !DILocation(line: 11, column: 16, scope: !11)
!26 = !DILocation(line: 11, column: 14, scope: !11)
!27 = !DILocation(line: 11, column: 21, scope: !11)
!28 = !DILocation(line: 11, column: 20, scope: !11)
!29 = !DILocation(line: 11, column: 18, scope: !11)
!30 = !DILocation(line: 11, column: 5, scope: !11)
!31 = distinct !DISubprogram(name: "floating", linkageName: "_Z8floatingdRdPd", scope: !12, file: !12, line: 14, type: !32, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!32 = !DISubroutineType(types: !33)
!33 = !{!34, !34, !35, !36}
!34 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!35 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !34, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!37 = !DILocalVariable(name: "a", arg: 1, scope: !31, file: !12, line: 14, type: !34)
!38 = !DILocation(line: 14, column: 25, scope: !31)
!39 = !DILocalVariable(name: "b", arg: 2, scope: !31, file: !12, line: 14, type: !35)
!40 = !DILocation(line: 14, column: 36, scope: !31)
!41 = !DILocalVariable(name: "c", arg: 3, scope: !31, file: !12, line: 14, type: !36)
!42 = !DILocation(line: 14, column: 47, scope: !31)
!43 = !DILocation(line: 16, column: 12, scope: !31)
!44 = !DILocation(line: 16, column: 16, scope: !31)
!45 = !DILocation(line: 16, column: 14, scope: !31)
!46 = !DILocation(line: 16, column: 21, scope: !31)
!47 = !DILocation(line: 16, column: 20, scope: !31)
!48 = !DILocation(line: 16, column: 18, scope: !31)
!49 = !DILocation(line: 16, column: 5, scope: !31)
!50 = distinct !DISubprogram(name: "structure", linkageName: "_Z9structure7structARS_PS_", scope: !12, file: !12, line: 19, type: !51, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!51 = !DISubroutineType(types: !52)
!52 = !{null, !53, !61, !60}
!53 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "structA", file: !12, line: 1, size: 320, flags: DIFlagTypePassByValue, elements: !54, identifier: "_ZTS7structA")
!54 = !{!55, !56, !57, !58, !59}
!55 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !53, file: !12, line: 2, baseType: !15, size: 32)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !53, file: !12, line: 3, baseType: !34, size: 64, offset: 64)
!57 = !DIDerivedType(tag: DW_TAG_member, name: "pa", scope: !53, file: !12, line: 4, baseType: !17, size: 64, offset: 128)
!58 = !DIDerivedType(tag: DW_TAG_member, name: "pb", scope: !53, file: !12, line: 5, baseType: !36, size: 64, offset: 192)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "psta", scope: !53, file: !12, line: 6, baseType: !60, size: 64, offset: 256)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !53, size: 64)
!62 = !DILocalVariable(name: "a", arg: 1, scope: !50, file: !12, line: 19, type: !53)
!63 = !DILocation(line: 19, column: 25, scope: !50)
!64 = !DILocalVariable(name: "b", arg: 2, scope: !50, file: !12, line: 19, type: !61)
!65 = !DILocation(line: 19, column: 37, scope: !50)
!66 = !DILocalVariable(name: "c", arg: 3, scope: !50, file: !12, line: 19, type: !60)
!67 = !DILocation(line: 19, column: 49, scope: !50)
!68 = !DILocation(line: 22, column: 1, scope: !50)
!69 = distinct !DISubprogram(name: "main", scope: !12, file: !12, line: 24, type: !70, scopeLine: 25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !7, retainedNodes: !9)
!70 = !DISubroutineType(types: !71)
!71 = !{!15}
!72 = !DILocalVariable(name: "local", scope: !69, file: !12, line: 26, type: !15)
!73 = !DILocation(line: 26, column: 9, scope: !69)
!74 = !DILocalVariable(name: "f", scope: !69, file: !12, line: 27, type: !34)
!75 = !DILocation(line: 27, column: 12, scope: !69)
!76 = !DILocalVariable(name: "s", scope: !69, file: !12, line: 28, type: !53)
!77 = !DILocation(line: 28, column: 13, scope: !69)
!78 = !DILocation(line: 30, column: 22, scope: !69)
!79 = !DILocation(line: 30, column: 13, scope: !69)
!80 = !DILocation(line: 30, column: 11, scope: !69)
!81 = !DILocation(line: 31, column: 19, scope: !69)
!82 = !DILocation(line: 31, column: 9, scope: !69)
!83 = !DILocation(line: 31, column: 7, scope: !69)
!84 = !DILocation(line: 32, column: 16, scope: !69)
!85 = !DILocation(line: 32, column: 5, scope: !69)
!86 = !DILocation(line: 33, column: 5, scope: !69)
