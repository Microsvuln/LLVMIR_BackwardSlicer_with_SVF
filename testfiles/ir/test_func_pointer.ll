; ModuleID = './src/test_func_pointer.cpp'
source_filename = "./src/test_func_pointer.cpp"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define i32 @_Z3fooi(i32 %a) #0 !dbg !10 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, i32* %a.addr, align 4, !dbg !17
  %add = add nsw i32 %0, 1, !dbg !18
  ret i32 %add, !dbg !19
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define i32 @main() #2 !dbg !20 {
entry:
  %retval = alloca i32, align 4
  %local = alloca i32, align 4
  %pfunc = alloca i32 (i32)*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %local, metadata !23, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.declare(metadata i32 (i32)** %pfunc, metadata !25, metadata !DIExpression()), !dbg !27
  store i32 (i32)* @_Z3fooi, i32 (i32)** %pfunc, align 8, !dbg !27
  %0 = load i32 (i32)*, i32 (i32)** %pfunc, align 8, !dbg !28
  %call = call i32 %0(i32 2), !dbg !28
  store i32 %call, i32* %local, align 4, !dbg !29
  ret i32 0, !dbg !30
}

attributes #0 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 13.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/")
!1 = !DIFile(filename: "src/test_func_pointer.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 13.0.0"}
!10 = distinct !DISubprogram(name: "foo", linkageName: "_Z3fooi", scope: !11, file: !11, line: 1, type: !12, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./src/test_func_pointer.cpp", directory: "/Users/ichang-yul/Desktop/SVF_Practice/testfiles")
!12 = !DISubroutineType(types: !13)
!13 = !{!14, !14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !11, line: 1, type: !14)
!16 = !DILocation(line: 1, column: 14, scope: !10)
!17 = !DILocation(line: 3, column: 12, scope: !10)
!18 = !DILocation(line: 3, column: 14, scope: !10)
!19 = !DILocation(line: 3, column: 5, scope: !10)
!20 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 6, type: !21, scopeLine: 7, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!21 = !DISubroutineType(types: !22)
!22 = !{!14}
!23 = !DILocalVariable(name: "local", scope: !20, file: !11, line: 8, type: !14)
!24 = !DILocation(line: 8, column: 9, scope: !20)
!25 = !DILocalVariable(name: "pfunc", scope: !20, file: !11, line: 9, type: !26)
!26 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!27 = !DILocation(line: 9, column: 11, scope: !20)
!28 = !DILocation(line: 11, column: 13, scope: !20)
!29 = !DILocation(line: 11, column: 11, scope: !20)
!30 = !DILocation(line: 13, column: 5, scope: !20)
