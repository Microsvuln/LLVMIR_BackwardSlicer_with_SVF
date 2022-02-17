#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"

#include <iostream>
#include <vector>
#include <string>

using SVF::SVFUtil::outs;
using SVF::SVFUtil::pasMsg;

// For getting llvm IR file as argv 
static llvm::cl::opt<std::string> InputFilename( llvm::cl::Positional,
        llvm::cl::desc( "<input bitcode>" ), llvm::cl::init( "-" ) );

int main( int argc, char *argv[] )
{
    int arg_num = 0;
    char **arg_value = new char*[argc];

    // Init arguments
    std::vector<std::string> moduleNameVec;
    SVF::SVFUtil::processArguments( argc, argv, arg_num, arg_value, moduleNameVec );
    llvm::cl::ParseCommandLineOptions( arg_num, arg_value, "Proto\n" );

    // Init svf module
    SVF::SVFModule *svfModule = SVF::LLVMModuleSet::getLLVMModuleSet()->buildSVFModule( moduleNameVec );
    svfModule->buildSymbolTableInfo();

    // Just print all things in llvm IR code
    for ( auto &func : *svfModule ) {
        auto llvmFunc = func->getLLVMFun();
        llvmFunc->print( outs() );
    }
    
    return 0;
}