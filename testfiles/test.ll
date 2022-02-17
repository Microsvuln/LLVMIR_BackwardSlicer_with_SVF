; ModuleID = './test_c.c'
source_filename = "./test_c.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx12.0.0"

@.str = private unnamed_addr constant [18 x i8] c"%d + %d + 1 = %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @foo(i32* %a) #0 !dbg !10 {
entry:
  %a.addr = alloca i32*, align 8
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !16, metadata !DIExpression()), !dbg !17
  %0 = load i32*, i32** %a.addr, align 8, !dbg !18
  %1 = load i32, i32* %0, align 4, !dbg !19
  %add = add nsw i32 %1, 1, !dbg !19
  store i32 %add, i32* %0, align 4, !dbg !19
  ret void, !dbg !20
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @bar(i32* %a, i32* %b) #0 !dbg !21 {
entry:
  %a.addr = alloca i32*, align 8
  %b.addr = alloca i32*, align 8
  store i32* %a, i32** %a.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %a.addr, metadata !24, metadata !DIExpression()), !dbg !25
  store i32* %b, i32** %b.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %b.addr, metadata !26, metadata !DIExpression()), !dbg !27
  %0 = load i32*, i32** %a.addr, align 8, !dbg !28
  call void @foo(i32* %0), !dbg !29
  %1 = load i32*, i32** %a.addr, align 8, !dbg !30
  %2 = load i32, i32* %1, align 4, !dbg !31
  %3 = load i32*, i32** %b.addr, align 8, !dbg !32
  %4 = load i32, i32* %3, align 4, !dbg !33
  %add = add nsw i32 %2, %4, !dbg !34
  ret i32 %add, !dbg !35
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main() #0 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %n1, metadata !39, metadata !DIExpression()), !dbg !40
  store i32 2, i32* %n1, align 4, !dbg !40
  call void @llvm.dbg.declare(metadata i32* %n2, metadata !41, metadata !DIExpression()), !dbg !42
  store i32 3, i32* %n2, align 4, !dbg !42
  %0 = load i32, i32* %n1, align 4, !dbg !43
  %1 = load i32, i32* %n2, align 4, !dbg !44
  %call = call i32 @bar(i32* %n1, i32* %n2), !dbg !45
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i64 0, i64 0), i32 %0, i32 %1, i32 %call), !dbg !46
  ret i32 0, !dbg !47
}

declare i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "Homebrew clang version 13.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX12.sdk", sdk: "MacOSX12.sdk")
!1 = !DIFile(filename: "test_c.c", directory: "/Users/ichang-yul/Desktop/svf-practice/test_c")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{i32 7, !"PIC Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 1}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"Homebrew clang version 13.0.1"}
!10 = distinct !DISubprogram(name: "foo", scope: !11, file: !11, line: 3, type: !12, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "./test_c.c", directory: "/Users/ichang-yul/Desktop/svf-practice/test_c")
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14}
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !11, line: 3, type: !14)
!17 = !DILocation(line: 3, column: 16, scope: !10)
!18 = !DILocation(line: 5, column: 6, scope: !10)
!19 = !DILocation(line: 5, column: 8, scope: !10)
!20 = !DILocation(line: 6, column: 1, scope: !10)
!21 = distinct !DISubprogram(name: "bar", scope: !11, file: !11, line: 8, type: !22, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DISubroutineType(types: !23)
!23 = !{!15, !14, !14}
!24 = !DILocalVariable(name: "a", arg: 1, scope: !21, file: !11, line: 8, type: !14)
!25 = !DILocation(line: 8, column: 15, scope: !21)
!26 = !DILocalVariable(name: "b", arg: 2, scope: !21, file: !11, line: 8, type: !14)
!27 = !DILocation(line: 8, column: 23, scope: !21)
!28 = !DILocation(line: 10, column: 10, scope: !21)
!29 = !DILocation(line: 10, column: 5, scope: !21)
!30 = !DILocation(line: 11, column: 13, scope: !21)
!31 = !DILocation(line: 11, column: 12, scope: !21)
!32 = !DILocation(line: 11, column: 18, scope: !21)
!33 = !DILocation(line: 11, column: 17, scope: !21)
!34 = !DILocation(line: 11, column: 15, scope: !21)
!35 = !DILocation(line: 11, column: 5, scope: !21)
!36 = distinct !DISubprogram(name: "main", scope: !11, file: !11, line: 14, type: !37, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{!15}
!39 = !DILocalVariable(name: "n1", scope: !36, file: !11, line: 16, type: !15)
!40 = !DILocation(line: 16, column: 9, scope: !36)
!41 = !DILocalVariable(name: "n2", scope: !36, file: !11, line: 17, type: !15)
!42 = !DILocation(line: 17, column: 9, scope: !36)
!43 = !DILocation(line: 19, column: 35, scope: !36)
!44 = !DILocation(line: 19, column: 39, scope: !36)
!45 = !DILocation(line: 19, column: 43, scope: !36)
!46 = !DILocation(line: 19, column: 5, scope: !36)
!47 = !DILocation(line: 21, column: 5, scope: !36)
