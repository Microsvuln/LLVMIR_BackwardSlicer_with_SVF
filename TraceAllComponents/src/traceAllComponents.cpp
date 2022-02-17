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
    llvm::cl::ParseCommandLineOptions( arg_num, arg_value, "trace all components\n" );

    // Init svf module
    SVF::SVFModule *svfModule = SVF::LLVMModuleSet::getLLVMModuleSet()->buildSVFModule( moduleNameVec );
    svfModule->buildSymbolTableInfo();

    // Iterate functions in svf Module
    // Also, can use iterator
    // begin() == FunctionSet.begin() vector<const SVFFunction*>
    // llvmFunBegin() == LLVMFunctionSet.begin() vector<Function*>
    for ( auto func : *svfModule ) {
        llvm::Function *llvmFunc = func->getLLVMFun();
        outs() << pasMsg( "Function : " + llvmFunc->getName().str() ) << "\n";

        // Iterate basic blocks in function
        for ( auto &basicBlock : *llvmFunc ) {
            outs() << "  " << pasMsg( "Basic Blocks : " ) << "\n"
                   << "  " << pasMsg( basicBlock.getName().str() ) << "\n";

            // Iterate instructions in basic block
            for ( auto &instruction : basicBlock ) {
                outs() << "  ";
                instruction.print( outs() );
                outs() << "\n";
                
                std::string opcode = instruction.getOpcodeName();
                outs() << "    " 
                       << pasMsg( "Opcode : " ) << opcode;
                int opno = instruction.getNumOperands();
                outs() << "\t"
                       << pasMsg( "Operand NO : ") << opno;

                outs() << "\t"
                       << pasMsg( "Operands : ");
                
                for ( int i = 0; i < opno; i ++ ) {
                    // outs() << pasMsg( instruction.getOperand( i )->getName().str() );                    
                    // instruction.getOperand( i )->print( outs() );
                    // outs() << *(instruction.getOperand( i )) ;
                    instruction.getOperand( i )->printAsOperand( outs() );
                    outs() << pasMsg( ", " );
                }
                outs() << "\n-------------------\n";
            }
        }
    }
    
    return 0;
}