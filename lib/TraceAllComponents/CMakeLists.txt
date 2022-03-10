set(CMAKE_OSX_ARCHITECTURES "x86_64")

llvm_map_components_to_libnames(llvm_libs bitwriter core ipo irreader instcombine instrumentation target linker analysis scalaropts support )

add_library(TraceAllComponents traceallcomponents.cpp)

target_compile_options(TraceAllComponents PUBLIC -g -Wall)
target_link_libraries(TraceAllComponents UtilDef ${SVF_LIB} ${LLVMCudd} ${llvm_libs} ${EXTRA_LIBS})
target_include_directories(TraceAllComponents PUBLIC "${PROJECT_SOURCE_DIR}/include")