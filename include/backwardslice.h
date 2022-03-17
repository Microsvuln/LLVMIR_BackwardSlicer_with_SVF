#ifndef BACKWARDSLICE_H_
#define BACKWARDSLICE_H_

#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"
#include "llvm/IR/ModuleSlotTracker.h"
#include "UtilDef.h"

#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;
using SVF::SVFUtil::pasMsg;

class Slice;
class Backward;

class Slice {
private:
    map <Value*, vector<Value*>*> *sliced_inst_list_;
    map <Value*, vector<Value*>*> *prev_branch_inst_list_by_block_;
    map <Value*, Value*> *pointing_value_table_;
    map <Value*, vector<Value*>*> *var_alias_list_;
    Value *return_value;
public:
    Slice()
        : sliced_inst_list_( new map<Value*, vector<Value*>*> )
        , prev_branch_inst_list_by_block_( new map<Value*, vector<Value*>*> )
        , pointing_value_table_( new map<Value*, Value*> )
        , var_alias_list_( new map<Value*, vector<Value*>*> )
        , return_value( nullptr )
    {}

    map<Value*, vector<Value*>*> *GetSlicedInstList( void ) const 
    {
        return sliced_inst_list_;
    }
    Value *GetReturnValue( void ) const
    {
        return return_value;
    }

    void SetPointingValue( Value *key, Value *pointee )
    {
        if ( pointing_value_table_->empty() || pointing_value_table_->find( key ) == pointing_value_table_->end() ) {
            pointing_value_table_->emplace( key, pointee );
        }
        else {
            (*pointing_value_table_)[key] = pointee;
        }
        
    }

    Value* GetPointingValue( Value *key )
    {
        //assert( pointing_value_table_->find( key ) != pointing_value_table_->end() &&
        //        "Not Found Key in getPointingValue" );
        
        if ( key == nullptr || pointing_value_table_->find( key ) == pointing_value_table_->end() ) {
            return nullptr;
        }
        
       return pointing_value_table_->at( key );
    }

    Value* FindAlias( Value *v )
    {
        if ( v == nullptr || var_alias_list_->empty() ) {
            return nullptr;
        }

        for ( auto it : *var_alias_list_ ) {
            for ( auto alias : *it.second ) {
                if ( alias == v ) {
                    return it.first;
                }
            }
        }
        return nullptr;
    }

    void AppendAlias( Value *key, Value *v )
    {
        if ( var_alias_list_->find( key ) == var_alias_list_->end() ) {
            var_alias_list_->emplace( key, new vector<Value*> );
        } 

        var_alias_list_->at( key )->push_back( v );
    }

    void AppendInstsByOperand( Value *result, Value *operand, UtilDef *util )
    {
        vector<Value*> tmp;
        map<Value*, vector<Value*>*>* resultMap;
        map<Value*, vector<Value*>*>* operandMap;
        assert( util != nullptr && "Util is nullptr" );
        
        if ( result->getValueID() == Value::BasicBlockVal ) {
            resultMap = prev_branch_inst_list_by_block_;
        }
        else {
            resultMap = sliced_inst_list_;
        }
        if ( resultMap->find( result ) == resultMap->end() ) {
            if ( result->getValueID() == Value::InstructionVal ) {
                Instruction *inst = dyn_cast<Instruction>( result );
                errs() << inst->getParent()->getParent()->getName().str() << " " << result->getValueID() << " " << util->inst2idx( result ) << "\n";
            }
            assert( resultMap->find( result ) != resultMap->end() && "Not Found result" );
        }
        // assert( sliced_inst_list_->find( operand ) == sliced_inst_list_->end() && "Not Found operand" );

        if ( operand->getValueID() == Value::BasicBlockVal ) {
            operandMap = prev_branch_inst_list_by_block_;
        }
        else {
            operandMap = sliced_inst_list_;
        }
        if ( operandMap->find( operand ) == operandMap->end() ) {
            return;
        }

        auto it1 = resultMap->at( result )->begin();
        auto it2 = operandMap->at( operand )->begin();
        while ( it1 != resultMap->at( result )->end() &&
                it2 != operandMap->at( operand )->end() ) {
            Instruction *inst1 = dyn_cast<Instruction>( *it1 );
            Function *func1 = inst1->getParent()->getParent();
            Instruction *inst2 = dyn_cast<Instruction>( *it2 );
            Function *func2 = inst2->getParent()->getParent();

            if ( !tmp.empty() && func1 != func2 ) {
                Instruction *topInst = dyn_cast<Instruction>( tmp.back() );
                Function *topFunc = topInst->getParent()->getParent();
                if ( topInst->getOpcode() == Instruction::Call ) {
                    if ( topFunc != func2 ) {
                        tmp.push_back( *it2 );
                        it2 ++;
                        continue;
                    }
                    else if ( topFunc != func1 ) {
                        tmp.push_back( *it1 );
                        it1 ++;
                        continue;
                    }
                }
                else {
                    if ( topFunc == func1 ) {
                        tmp.push_back( *it1 );
                        it1 ++;
                        continue;
                    }
                    else if ( topFunc == func2 ) {
                        tmp.push_back( *it2 );
                        it2 ++;
                        continue;
                    }
                }
            }

            if ( util->inst2idx( *it1 ) == util->inst2idx( *it2 ) ) {
                tmp.push_back( *it1 );
                it1 ++;
                it2 ++;
            }
            else if ( util->inst2idx( *it1 ) < util->inst2idx( *it2 ) ) {
                tmp.push_back( *it1 );
                it1 ++;
            }
            else {
                tmp.push_back( *it2 );
                it2 ++;
            }
        }
        while ( it1 != resultMap->at( result )->end() ) {
            tmp.push_back( *it1 );
            it1 ++;
        }
        while ( it2 != operandMap->at( operand )->end() ) {
            tmp.push_back( *it2 );
            it2 ++;
        }

        resultMap->at( result )->clear();

        // A <- B : merge B to A
        // basicblock <- basicblock, variable <- basicblock
        // => just merge
        // variable <- variable, basicblock <- variable
        // => consider change basicblock
        if ( operand->getValueID() == Value::BasicBlockVal ) {
            for( auto v : tmp ) {
                resultMap->at( result )->push_back( v );
            }
        }
        else {
            BasicBlock* pred = nullptr;
            for( auto v : tmp ) {
                Instruction *inst = dyn_cast<Instruction>( v );
                if ( pred != inst->getParent() ) {
                    AppendInstsByOperand( result, inst->getParent(), util );
                }
                resultMap->at( result )->push_back( v );
                pred = inst->getParent();
            }
        }
    }

    void AppendInst( Value *key, Value *v, UtilDef *util )
    {
        map<Value*, vector<Value*>*>* target;
        
        if ( key->getValueID() == Value::BasicBlockVal ) {
            target = prev_branch_inst_list_by_block_;
        }
        else {
            target = sliced_inst_list_;
        }
        if ( target->find( key ) == target->end() ) {
            target->emplace( key, new vector<Value*> );
        }
        if ( !target->at( key )->empty() ) {
            Instruction *i1 = dyn_cast<Instruction>( target->at( key )->back() );
            Instruction *i2 = dyn_cast<Instruction>( v );
            if ( i1->getParent() != i2->getParent() ) {
                AppendInstsByOperand( key, i2->getParent(), util );
            }
        }
        else {
            Instruction *inst = dyn_cast<Instruction>( v );
            AppendInstsByOperand( key, inst->getParent(), util );
        }
        target->at( key )->push_back( v );
    }

    bool isKey( Value *v )
    {
        if ( sliced_inst_list_->find( v ) == sliced_inst_list_->end() ) {
            return false;
        }

        return true;
    }

    void PrintInstByValue( Value *v, UtilDef *util )
    {
        map<Value*, vector<Value*>*> *list;
        if ( v->getValueID() == Value::BasicBlockVal ) {
            outs() << "Basicblock" << "\n";
            list = prev_branch_inst_list_by_block_;
        }
        else {
            outs() << "Value" << "\n";
            list = sliced_inst_list_;
        }
        if ( list->at( v )->empty() ) {
            outs() << "empty vector\n------" << "\n";
            return ;
        }
        for ( auto it : *( list->at( v ) ) ) {
            outs() << util->inst2str( it ) << "\n";
        }
        outs() << "-------\n";

    }

    void SliceInst( Instruction *inst, UtilDef *util ) {
        // outs() << pasMsg("[DEBUG] ") << pasMsg( util->inst2str( inst ) ) << "\n";
        switch ( inst->getOpcode() ) {

        case Instruction::Alloca :
        {
            AppendInst( inst, inst, util );
            break;
        }
        case Instruction::GetElementPtr :
        {
            GetElementPtrInst *gepinst = dyn_cast<GetElementPtrInst>( inst );
            Value *object = inst->getOperand( 0 );
            if ( gepinst->getResultElementType()->isPointerTy() ) {
                // outs() << pasMsg( "[DEBUG] Append alias!\n" );
                AppendAlias( GetPointingValue( object ), inst );
            }
            Value *alias = FindAlias( inst );
            Value *aliasPointee = GetPointingValue( alias );
            if ( alias != nullptr && aliasPointee != nullptr ) {
                SetPointingValue( inst, aliasPointee );
            }

            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, object, util );
            break;
        }
        case Instruction::Store :
        {
            Value *value = inst->getOperand( 0 );
            Value *var = inst->getOperand( 1 );

            if ( value->getValueID() == Value::ArgumentVal ) {
                // outs() << pasMsg( "[DEBUG] Argument Value\n" );
                AppendInst( value, inst, util );
            }

            if ( value->getType()->isPointerTy() ) {
                // outs() << pasMsg( "[DEBUG] Insert Pointer!\n" );
                SetPointingValue( var, value );
            }

            AppendInst( var, inst, util );
            AppendInstsByOperand( var, value, util );

            Value *alias = FindAlias( var );
            if ( alias != nullptr ) {
                AppendInstsByOperand( alias, var, util );
            }
            
            break;
        }
        
        // Assume operand 0 is not temporary( unnamed variable )
        case Instruction::Load :
        {
            Value *var = inst->getOperand( 0 );
            Value *varPointee = GetPointingValue( var );

            if ( varPointee != nullptr ) {
                outs() << pasMsg( "[DEBUG] Append alias!\n" );
                AppendAlias( varPointee, inst );
            }

            Value *alias = FindAlias( inst );
            Value *aliasPointee = GetPointingValue( alias );
            if ( alias != nullptr && aliasPointee != nullptr ) {
                SetPointingValue( inst, aliasPointee );
            }

            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, var, util );
            break;
        }
        
        // term ops
        case Instruction::Br :
        case Instruction::Switch :
        {
            Value *value = inst->getOperand( 0 );

            if ( value->getValueID() == Value::BasicBlockVal ) {
                AppendInst( value, inst, util );
                break;
            }
            vector<Value*> labels;
            for ( int i = 1; i < inst->getNumOperands(); i ++ ) {
                if ( inst->getOperand( i )->getValueID() == Value::BasicBlockVal ) {
                    labels.push_back( inst->getOperand( i ) );
                }
            }

            for ( auto label : labels ) {
                AppendInst( label, inst, util );
                AppendInstsByOperand( label, value, util );
            }
            break;
        }
        
        // other ops
        case Instruction::ICmp :
        case Instruction::FCmp :
        /*
        {
            AppendInst( &inst, &inst, util );
            for ( auto o : operands ) {
                if ( isKey( o ) ) {
                    AppendInstsByOperand( &inst, o, util );
                }
            }
            break;
        }
        */
        // binary operators
        case Instruction::Add  :
        case Instruction::FAdd :
        case Instruction::Sub  :
        case Instruction::FSub :
        case Instruction::Mul  :
        case Instruction::FMul :
        case Instruction::UDiv :
        case Instruction::SDiv :
        case Instruction::FDiv :
        case Instruction::URem :
        case Instruction::SRem :
        case Instruction::FRem :
        // bitwise operators
        case Instruction::Shl :
        case Instruction::LShr :
        case Instruction::AShr :
        case Instruction::And :
        case Instruction::Or :
        case Instruction::Xor :
        {
            Value *op1 = inst->getOperand( 0 );
            Value *op2 = inst->getOperand( 1 );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, op1, util );
            AppendInstsByOperand( inst, op2, util );
            break;
        }

        
        case Instruction::Select :
        {
            Value *op1 = inst->getOperand( 0 );
            Value *op2 = inst->getOperand( 1 );
            Value *op3 = inst->getOperand( 2 );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, op1, util );
            AppendInstsByOperand( inst, op2, util );
            AppendInstsByOperand( inst, op3, util );
            break;
        }
        
        case Instruction::AtomicCmpXchg :
        {
            assert( false && "AtomicCmpXchg" );
            Value *op1 = inst->getOperand( 0 );
            Value *op3 = inst->getOperand( 2 );
            AppendInstsByOperand( op1, op3, util );
            break;
        }
        case Instruction::AtomicRMW :
        {
            assert( false && "AtomicRMW" );
            Value *op1 = inst->getOperand( 0 );
            Value *op2 = inst->getOperand( 1 );
            AppendInstsByOperand( op1, op2, util );
            break;
        }
        case Instruction::Call :
        {
            //assert( false && "Call" );
            CallInst *callinst = dyn_cast<CallInst>( inst );
            Function *calledFunc = callinst->getCalledFunction();
            if ( calledFunc->getName() == "llvm.dbg.declare" ) {
                break;
            }
            /*
            for ( auto &bb : *calledFunc ) {
                for ( auto &ins : bb ) {
                    SliceInst( &ins, util ); 
                }
            }
            
            auto it = calledFunc->arg_begin();
            for ( int i = 0; i < inst->getNumOperands() - 1 && it != calledFunc->arg_end(); i ++, it ++ ) {
                Value *arg = dyn_cast<Value>( &(*it) );
                AppendInstsByOperand( arg, inst->getOperand( i ), util );
            }
            */
            AppendInst( inst, inst, util );
            for ( int i = 0; i < inst->getNumOperands() - 1; i ++ ) {
                AppendInstsByOperand( inst, inst->getOperand( i ), util );
            }
            
            break;
        }
        case Instruction::ShuffleVector :
        {
            assert( false && "ShuffleVector" );
            Value *op1 = inst->getOperand( 0 );
            Value *op2 = inst->getOperand( 1 );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, op1, util );
            AppendInstsByOperand( inst, op2, util );
            break;
        }
        case Instruction::Ret :
        {  
            //assert( false && "Ret" );
            if ( inst->getNumOperands() > 0 )
                return_value = inst->getOperand( 0 );
            break;
        }
        case Instruction::PHI :
        {
            //assert( false && "PHI" );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
            AppendInstsByOperand( inst, inst->getOperand( 1 ), util );
            break;
        }
        case Instruction::InsertElement :
        {
            assert( false && "InsertElement" );
            Value *op1 = inst->getOperand( 0 );
            Value *op2 = inst->getOperand( 1 );
            AppendInstsByOperand( op1, op2, util );
            break;
        }
        case Instruction::InsertValue :
        {
            
            //assert( false && "InsertValue" );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
            AppendInstsByOperand( inst, inst->getOperand( 1 ), util );
            
            break;
        }
        case Instruction::Fence :
        {
            assert( false && "Fence" );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
            AppendInstsByOperand( inst, inst->getOperand( 1 ), util );
            break;
        }
        case Instruction::ExtractElement :
        {
            assert( false && "ExtractElement" );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
            break;
        }
        case Instruction::ExtractValue :
        {
            //assert( false && "ExtractValue" );
            AppendInst( inst, inst, util );
            AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
            break;
        }
        case Instruction::LandingPad :
        {
            //assert( false && "LandingPad" );
            AppendInst( inst, inst, util );
            break;
        }
        // casting operators
        case Instruction::Trunc :
        case Instruction::ZExt :
        case Instruction::SExt :
        case Instruction::FPTrunc :
        case Instruction::FPExt :
        case Instruction::FPToUI :
        case Instruction::FPToSI :
        case Instruction::UIToFP :
        case Instruction::SIToFP :
        case Instruction::PtrToInt :
        case Instruction::IntToPtr :
        case Instruction::BitCast :
        case Instruction::AddrSpaceCast :
        {
            //assert( false && "PtrToInt" );
            AppendInst( inst, inst, util );
            //AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
            break;
        }

        // Just Pass
        case Instruction::Unreachable :
        {
            break;
        }

        default:
            outs() << "assert : " << inst->getOpcodeName() << "\n";
            outs() << "assert : " << util->inst2str( inst ) << "\n";
            assert( false && "Not handled instruction" );
            break;
        }
    }
};

class Backward {
private:
    map <Value*, Slice*> *slice_list_by_func_;
    UtilDef *util;
public:
    Backward()
        : slice_list_by_func_( new map <Value*, Slice*> )
        , util( new UtilDef() )
    {}

    void SliceFunction( Function *func )
    {
        slice_list_by_func_->emplace( func, new Slice() );
        for( auto &bb : *func ) {
            for( auto &inst : bb ) {
                slice_list_by_func_->at( func )->SliceInst( &inst, util );
            }
        }
    }

    void PrintByFunction( Function *func )
    {
        Slice *s = slice_list_by_func_->at( func );

        for ( auto it : *( s->GetSlicedInstList() ) ) {
            std::string name = it.first->getName().str();
            if ( !name.empty() ) {
                outs() << pasMsg( "VAR : " ) << name << "\n";
            }
            else {
                outs() << pasMsg( "VAR : " ) << util->inst2str( it.first ) << "\n";
            }

            outs() << "Function : " << func->getName().str() << "\n";
            outs() << "ARG : ";
            for ( auto it = func->arg_begin(); it != func->arg_end(); it ++ ) {
                outs() << (*it).getName().str() << ", ";
            }
            outs() << "\n";

            BasicBlock *predBB = nullptr;
            for ( auto value : *( it.second ) ) {
                Instruction *inst = dyn_cast<Instruction>( value );
                if ( predBB != inst->getParent() ) {
                    outs() << inst->getParent()->getName().str() << ":\n";
                }
                predBB = inst->getParent();
                
                outs() << util->inst2str( value ) << "\n";
                
                if ( inst->getOpcode() == Instruction::Call ) {
                    Function *callee = dyn_cast<Function>( inst->getOperand( inst->getNumOperands() - 1 ) );
                    Slice *calleeSlice = slice_list_by_func_->at( callee );

                    map<Function*, int> *call_count_table = new map<Function*, int>;
                    call_count_table->emplace( func, 1 );

                    PrintByValue( callee, calleeSlice->GetReturnValue(), "  | ", call_count_table );
                    outs() << "  retval :" << util->inst2str( calleeSlice->GetReturnValue() ) << "\n";
                }
            }
        }
    }

    void PrintByValue( Function *func, Value *v, const string padding, map<Function*, int> *call_count_table )
    {
        assert( func != nullptr && "PrintByValue : Function is nullptr" );
        //assert( v != nullptr && "PrintByValue : Value is nullptr" );
        if ( v == nullptr ) {
            outs() << padding << "No return" << "\n";
            return;
        }

        if ( v->getValueID() <= Value::InstructionVal ) {
            //outs() << padding << "retval :" << ConstValueToStr( v ) << "\n";
            return;
        }

        if ( call_count_table->find( func ) != call_count_table->end() ) {
            (*call_count_table)[func] ++;
            if ( call_count_table->at( func ) >= 3 ) {
                outs() << padding << "Called more than 3 times" << "\n";
                return;
            }
        }
        else {
            call_count_table->emplace( func, 1 );
        }

        Slice *s = slice_list_by_func_->at( func );

        outs() << padding << "Function : " << func->getName().str() << "\n";
        outs() << padding << "ARG : ";
        for ( auto it = func->arg_begin(); it != func->arg_end(); it ++ ) {
            outs() << (*it).getName().str() << ", ";
        }
        outs() << "\n";

        BasicBlock *predBB = nullptr;
        for ( auto value : *( s->GetSlicedInstList()->at( v ) ) ) {
            Instruction *inst = dyn_cast<Instruction>( value );
            if ( predBB != inst->getParent() ) {
                outs() << padding << inst->getParent()->getName().str() << ":\n";
            }
            predBB = inst->getParent();

            outs() << padding << util->inst2str( value ) << "\n";

            if ( inst->getOpcode() == Instruction::Call ) {
                Function *callee = dyn_cast<Function>( inst->getOperand( inst->getNumOperands() - 1 ) );
                Slice *calleeSlice = slice_list_by_func_->at( callee );

                PrintByValue( callee, calleeSlice->GetReturnValue(), "  " + padding , call_count_table );
                outs() << padding << "retval :" << util->inst2str( calleeSlice->GetReturnValue() ) << "\n";
            }            
        }
    }

    std::string ConstValueToStr( Value *v )
    {
        std::string result;
        switch ( v->getValueID() ) {
        case Value::ConstantIntVal :
        {
            ConstantInt *constint = dyn_cast<ConstantInt>( v );
            result = std::to_string( constint->getSExtValue() );
            break;
        }
        case Value::ConstantFPVal :
        {
            ConstantFP *constfp = dyn_cast<ConstantFP>( v );
            result = std::to_string( constfp->getValueAPF().convertToDouble() );
            break;
        }
        default:
            result = "null";
            break;
        }
        return result;
    }

};

#endif