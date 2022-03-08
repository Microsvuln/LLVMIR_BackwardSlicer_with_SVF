#include "backwardslice.h"
#include "traceallcomponents.h"

// For getting llvm IR file as argv 
static llvm::cl::opt<std::string> InputFilename( llvm::cl::Positional,
        llvm::cl::desc( "<input bitcode>" ), llvm::cl::init( "-" ) );

int main( int argc, char *argv[] )
{
    UtilDef *util = new UtilDef;
    int arg_num = 0;
    char **arg_value = new char*[argc];

    // Init arguments
    std::vector<std::string> moduleNameVec;
    SVF::SVFUtil::processArguments( argc, argv, arg_num, arg_value, moduleNameVec );
    llvm::cl::ParseCommandLineOptions( arg_num, arg_value, "bwInstLists all components\n" );

    // Init svf module
    SVF::SVFModule *svfModule = SVF::LLVMModuleSet::getLLVMModuleSet()->buildSVFModule( moduleNameVec );
    svfModule->buildSymbolTableInfo();

    Backward *bw = new Backward;

    PrintAllComponent( svfModule );

    for ( auto func : *svfModule ) {
        Function *llvmFunc = func->getLLVMFun();
        bw->SliceFunction( llvmFunc );
    }
    for ( auto func : *svfModule ) {
        Function *llvmFunc = func->getLLVMFun();
        bw->PrintByFunction( llvmFunc );
    }
    
    delete util;
    delete bw;
    
    return 0;
}