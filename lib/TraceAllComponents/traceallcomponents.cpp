#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"
#include "UtilDef.h"

#include <iostream>
#include <vector>
#include <string>

using namespace SVF;
using SVF::SVFUtil::pasMsg;

void PrintAllComponent( SVF::SVFModule *svfModule )
{
    UtilDef *util = new UtilDef;

    // Iterate functions in svf Module
    // Also, can use iterator
    // begin() == FunctionSet.begin() vector<const SVFFunction*>
    // llvmFunBegin() == LLVMFunctionSet.begin() vector<Function*>
    for ( auto func : *svfModule ) {
        llvm::Function *llvmFunc = func->getLLVMFun();
        outs() << pasMsg( "Function : " + llvmFunc->getName().str() ) << "\n";
        outs() << pasMsg( "ARG : ");
        for ( auto it = llvmFunc->arg_begin(); it != llvmFunc->arg_end(); it ++ ) {
            outs() << pasMsg( (*it).getName().str() ) << ", ";
        }
        outs() << "\n";

        util->instIdxer( llvmFunc );

        // Iterate basic blocks in function
        for ( auto &basicBlock : *llvmFunc ) {
            outs() << "  " << pasMsg( "Basic Blocks : " ) << "\n"
                   << "  " << pasMsg( basicBlock.getName().str() ) << "\n";

            // Iterate instructions in basic block
            for ( auto &instruction : basicBlock ) {
                Instruction *inst = &instruction;
                outs() << pasMsg( "<" ) << util->inst2idx( inst ) << pasMsg( util->inst2str( inst ) ) << pasMsg( " >" )
                       << pasMsg( " : " ) << inst << "\n";
                outs() << pasMsg( "TYPE : " ) << pasMsg( util->getOperatorTypeName( inst ) ) << "\n";
                unsigned int opcode = inst->getOpcode();

                for ( int i = 0; i < inst->getNumOperands(); i ++ ) {
                    llvm::Value *operand = inst->getOperand( i );
                    std::string operandName = operand->getName().str();
                    Type::TypeID tid = operand->getType()->getTypeID();
                    outs() << pasMsg( "OPERAND : " ) << pasMsg( operandName ) << "\t\t";

                    unsigned int valueID = operand->getValueID();
                    if ( valueID == llvm::Value::ConstantIntVal ) {
                        llvm::ConstantInt *constint = dyn_cast<ConstantInt>( operand );
                        outs() << pasMsg( "Int Val! : " ) << pasMsg( std::to_string( constint->getSExtValue() ) );
                    }
                    else {
                        outs() << pasMsg( "ValueID : " ) << pasMsg( std::to_string( operand->getValueID() ) );                               
                    }
                    outs() << pasMsg( "  type : ") << operand->getType()->getTypeID();
                    if ( operand->getType()->getTypeID() == Type::PointerTyID ) {
                        outs() << " " << operand->getType()->getContainedType( 0 )->getTypeID();
                    }
                        
                    outs() << " : " << operand << "\n";
                }
            }
        }
    }
}