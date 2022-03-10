set(CMAKE_OSX_ARCHITECTURES "x86_64")

llvm_map_components_to_libnames(llvm_libs bitwriter core ipo irreader instcombine instrumentation target linker analysis scalaropts support )

add_library(UtilDef UtilDef.cpp)

target_compile_options(UtilDef PUBLIC -g -Wall)
target_link_libraries(UtilDef ${SVF_LIB} ${LLVMCudd} ${llvm_libs} ${EXTRA_LIBS})
target_include_directories(UtilDef PUBLIC "${PROJECT_SOURCE_DIR}/include")