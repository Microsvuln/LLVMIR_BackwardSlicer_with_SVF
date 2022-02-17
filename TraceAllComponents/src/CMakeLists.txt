# This cmake file is modified by below link
# https://github.com/SVF-tools/SVF-example/blob/master/src/CMakeLists.txt

llvm_map_components_to_libnames(llvm_libs bitwriter core ipo irreader instcombine instrumentation target linker analysis scalaropts support )

add_executable( traceAllComponents traceAllComponents.cpp )
add_executable( printAllComponents printAllComponents.cpp )

target_link_libraries( printAllComponents ${SVF_LIB} ${LLVMCudd} ${llvm_libs} )
set_target_properties( printAllComponents PROPERTIES
                       RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )

target_link_libraries( traceAllComponents ${SVF_LIB} ${LLVMCudd} ${llvm_libs} )
set_target_properties( traceAllComponents PROPERTIES
                       RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
