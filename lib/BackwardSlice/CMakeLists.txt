set(CMAKE_OSX_ARCHITECTURES "x86_64")

llvm_map_components_to_libnames(llvm_libs bitwriter core ipo irreader instcombine instrumentation target linker analysis scalaropts support )

add_library(BackwardSlice backwardslice.cpp)

target_compile_options(BackwardSlice PUBLIC -g -Wall)
target_link_libraries(BackwardSlice UtilDef ${SVF_LIB} ${LLVMCudd} ${llvm_libs} ${EXTRA_LIBS})
target_include_directories(BackwardSlice PUBLIC "${PROJECT_SOURCE_DIR}/include")