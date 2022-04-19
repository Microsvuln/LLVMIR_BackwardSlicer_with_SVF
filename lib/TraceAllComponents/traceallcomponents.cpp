#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"
#include "UtilDef.h"

#include <llvm/IR/Attributes.h>

#include <iostream>
#include <vector>
#include <string>

using namespace SVF;
using SVF::SVFUtil::pasMsg;

/*
void PrintOperands( Value *value )
{
    uint32_t valueid = value->getValueID();
    Instruction *inst;
    ConstantExpr *constexprval;

    if ( Value::InstructionVal + Instruction::TermOpsBegin <= valueid && valueid <= Value::InstructionVal + Instruction::OtherOpsEnd ) {
        inst = dyn_cast<Instruction>( value );
    }
    if ( valueid == Value::ConstantExprVal ) {
        ConstantExpr *
    }

    for ( int i = 0; i < inst->getNumOperands(); i ++ ) {
        llvm::Value *operand = inst->getOperand( i );
        std::string operandName = operand->getName().str();
        //Type::TypeID tid = operand->getType()->getTypeID();
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
*/

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

                for ( uint32_t i = 0; i < inst->getNumOperands(); i ++ ) {
                    llvm::Value *operand = inst->getOperand( i );
                    std::string operandName = operand->getName().str();
                    //Type::TypeID tid = operand->getType()->getTypeID();
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

void PrintByFunction( llvm::Function *func )
{
    UtilDef *util = new UtilDef;

    outs() << pasMsg( "Function : " + func->getName().str() ) << "\n";
    outs() << pasMsg( "ARG : ");
    for ( auto it = func->arg_begin(); it != func->arg_end(); it ++ ) {
        outs() << pasMsg( (*it).getName().str() ) << ", ";
    }
    outs() << "\n";

    util->instIdxer( func );

    // Iterate basic blocks in function
    for ( auto &basicBlock : *func ) {
        outs() << "  " << pasMsg( "Basic Blocks : " ) << "\n"
                << "  " << pasMsg( basicBlock.getName().str() ) << "\n";

        // Iterate instructions in basic block
        for ( auto &instruction : basicBlock ) {
            Instruction *inst = &instruction;
            outs() << pasMsg( "<" ) << util->inst2idx( inst ) << pasMsg( util->inst2str( inst ) ) << pasMsg( " >" )
                    << pasMsg( " : " ) << inst << "\n";
            outs() << pasMsg( "TYPE : " ) << pasMsg( util->getOperatorTypeName( inst ) ) << " : " << inst->getOpcode() << "\n";
            //uint32_t opcode = inst->getOpcode();

            for ( uint32_t i = 0; i < inst->getNumOperands(); i ++ ) {
                llvm::Value *operand = inst->getOperand( i );
                std::string operandName = operand->getName().str();
                //Type::TypeID tid = operand->getType()->getTypeID();
                outs() << pasMsg( "OPERAND : " ) << pasMsg( operandName ) << "\t\t";

                uint32_t valueID = operand->getValueID();
                if ( valueID == llvm::Value::ConstantIntVal ) {
                    llvm::ConstantInt *constint = dyn_cast<ConstantInt>( operand );
                    outs() << pasMsg( "Int Val! : " ) << pasMsg( std::to_string( constint->getSExtValue() ) );
                }
                else if ( valueID == llvm::Value::GlobalVariableVal ) {
                    llvm::GlobalVariable *global = dyn_cast<GlobalVariable>( operand );
                    outs() << pasMsg( "Global Val! : " );
                    global->print( outs() );
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
            if ( inst->getOpcode() == Instruction::Call ) {
                CallInst *ci = dyn_cast<CallInst>( inst );
                Value *called_op = ci->getCalledOperand();
                Function *calledFunc;
                if ( called_op->getValueID() == Value::FunctionVal ) {
                    calledFunc = dyn_cast<Function>( called_op );
                }
                else if ( called_op->getValueID() == Value::ConstantExprVal ) {
                    outs() << "constexpr call : ";
                    called_op->print( outs() );
                    outs() << "\n";

                    ConstantExpr *ce_op = dyn_cast<ConstantExpr>( called_op );
                    
                    for ( uint32_t i = 0; i < ce_op->getNumOperands(); i ++ ) {
                        Value *operand = ce_op->getOperand( i );
                        std::string operandName = operand->getName().str();
                        //Type::TypeID tid = operand->getType()->getTypeID();
                        outs() << pasMsg( "  OPERAND : " ) << pasMsg( operandName ) << "\t\t";

                        uint32_t valueID = operand->getValueID();
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
                    continue;
                }
                else {
                    outs() << called_op->getValueID() << " : " << called_op->getValueName() << " indirect call\n";
                    continue;
                }

                /*
                inst->getMetadata();
                Value::
                
               
                */
                //outs() << "Func type : ";
                //outs() << calledFunc->getReturnType()
                if ( calledFunc->getReturnType()->isVoidTy() ) {
                    outs() << "void function\n";
                }
                else {
                    outs() << "Not void function\n";
                }

                outs() << "param, arg : ";
                for ( uint32_t i = 0; i < ci->getNumArgOperands(); i ++ ) {
                    Value *param = ci->getArgOperand( i );
                    Value *arg = calledFunc->getArg( i );
                    outs() << param->getName() << ", " << arg->getName() << " | ";
                }

                outs() << "\nParam Attr : ";
                for ( uint32_t i = 0; i < ci->getNumOperands() - 1; i ++ ) {
                    //Attribute::hasAttribute(StringRef Kind) 
                    Attribute attr = calledFunc->getArg( i )->getAttribute(Attribute::AttrKind::Dereferenceable);
                    auto op = ci->getOperand( i );
                    op->getType()->print( outs() );
                    outs() << ":" << attr.getAsString();
                    
                    outs() << ", ";
                }
                outs() << "\n";
            }
        }
    }
}