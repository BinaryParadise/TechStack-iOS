; ModuleID = 'main.m'
source_filename = "main.m"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-ios12.2.0-simulator"

%0 = type opaque
%struct._class_t = type { %struct._class_t*, %struct._class_t*, %struct._objc_cache*, i8* (i8*, i8*)**, %struct._class_ro_t* }
%struct._objc_cache = type opaque
%struct._class_ro_t = type { i32, i32, i32, i8*, i8*, %struct.__method_list_t*, %struct._objc_protocol_list*, %struct._ivar_list_t*, i8*, %struct._prop_list_t* }
%struct.__method_list_t = type { i32, i32, [0 x %struct._objc_method] }
%struct._objc_method = type { i8*, i8*, i8* }
%struct._objc_protocol_list = type { i64, [0 x %struct._protocol_t*] }
%struct._protocol_t = type { i8*, i8*, %struct._objc_protocol_list*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct._prop_list_t*, i32, i32, i8**, i8*, %struct._prop_list_t* }
%struct._ivar_list_t = type { i32, i32, [0 x %struct._ivar_t] }
%struct._ivar_t = type { i64*, i8*, i8*, i32, i32 }
%struct._prop_list_t = type { i32, i32, [0 x %struct._prop_t] }
%struct._prop_t = type { i8*, i8* }
%struct.__NSConstantString_tag = type { i32*, i32, i8*, i64 }

@"OBJC_CLASS_$_NSString" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_" = internal global %struct._class_t* @"OBJC_CLASS_$_NSString", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@.str = private unnamed_addr constant [15 x i8] c"BinaryParadise\00", align 1
@OBJC_METH_VAR_NAME_ = private unnamed_addr constant [20 x i8] c"initWithUTF8String:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_ = internal externally_initialized global i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@__CFConstantStringClassReference = external global [0 x i32]
@.str.1 = private unnamed_addr constant [11 x i8] c"%@ rank %d\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_ = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0), i64 10 }, section "__DATA,__cfstring", align 8
@llvm.compiler.used = appending global [3 x i8*] [i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_" to i8*), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_ to i8*)], section "llvm.metadata"

; Function Attrs: noinline optnone ssp uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca %0*, align 8
  %5 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %6 = call i8* @llvm.objc.autoreleasePoolPush() #1
  store i32 8, i32* %2, align 4
  store i32 8, i32* %3, align 4
  %7 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %8 = bitcast %struct._class_t* %7 to i8*
  %9 = call i8* @objc_alloc(i8* %8)
  %10 = bitcast i8* %9 to %0*
  %11 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !14
  %12 = bitcast %0* %10 to i8*
  %13 = call i8* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to i8* (i8*, i8*, i8*)*)(i8* %12, i8* %11, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str, i64 0, i64 0))
  %14 = bitcast i8* %13 to %0*
  store %0* %14, %0** %4, align 8
  %15 = load i32, i32* %2, align 4
  %16 = load i32, i32* %3, align 4
  %17 = add nsw i32 %15, %16
  store i32 %17, i32* %5, align 4
  %18 = load %0*, %0** %4, align 8
  %19 = load i32, i32* %5, align 4
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_ to i8*), %0* %18, i32 %19)
  %20 = bitcast %0** %4 to i8**
  call void @llvm.objc.storeStrong(i8** %20, i8* null) #1
  call void @llvm.objc.autoreleasePoolPop(i8* %6)
  ret i32 0
}

; Function Attrs: nounwind
declare i8* @llvm.objc.autoreleasePoolPush() #1

declare i8* @objc_alloc(i8*)

; Function Attrs: nonlazybind
declare i8* @objc_msgSend(i8*, i8*, ...) #2

declare void @NSLog(i8*, ...) #3

; Function Attrs: nounwind
declare void @llvm.objc.storeStrong(i8**, i8*) #1

; Function Attrs: nounwind
declare void @llvm.objc.autoreleasePoolPop(i8*) #1

attributes #0 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nonlazybind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!llvm.linker.options = !{!9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 12, i32 2]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 0}
!5 = !{i32 1, !"Objective-C Is Simulated", i32 32}
!6 = !{i32 1, !"Objective-C Class Properties", i32 64}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{i32 7, !"PIC Level", i32 2}
!9 = !{!"-framework", !"Foundation"}
!10 = !{!"-framework", !"CFNetwork"}
!11 = !{!"-framework", !"Security"}
!12 = !{!"-framework", !"CoreFoundation"}
!13 = !{!"clang version 9.0.0 (git@github.com:BinaryParadise/clang.git 6390f2badc629ecf299b5b0696f1f7fc06fda269) (git@github.com:llvm-mirror/llvm.git ffe57b5e41b4027157dc01e8f9626b2e4be28eae)"}
!14 = !{}
