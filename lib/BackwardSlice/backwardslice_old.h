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

class Backward {
private:
    map<Value*, vector<Value*>*> *mBwInstLists;
    map<Value*, vector<Value*>*> *mBwValueToFindLists;
    map<Value*, vector<Value*>*> *mBwBlockLists;
    map<Value*, Value*> *mBwPointingValue;
    map<Value*, vector<Value*>*> *mBwAliasLists;
    map<Value*, Value*> *mBwRetValues;
public:
    Backward()
        : mBwInstLists( new map<Value*, vector<Value*>*> )
        , mBwValueToFindLists( new map<Value*, vector<Value*>*> )
        , mBwBlockLists( new map<Value*, vector<Value*>*> )
        , mBwPointingValue( new map<Value*, Value*> )
        , mBwAliasLists( new map<Value*, vector<Value*>*> )
        , mBwRetValues( new map<Value*, Value*> )
    {}

    void SliceInst( Instruction *inst, UtilDef *util ) {
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
            outs() << pasMsg( "[DEBUG] Append alias!\n" );
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

        if ( value->getType()->isPointerTy() ) {
            outs() << pasMsg( "[DEBUG] Insert Pointer!\n" );
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
    // binary ops
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
        Value *op2 = inst->getOperand( 1 );
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
        CallInst *callinst = dyn_cast<CallInst>( inst );
        Function *calledFunc = callinst->getCalledFunction();
        if ( calledFunc->getName() == "llvm.dbg.declare" ) {
            break;
        }
        for ( auto &bb : *calledFunc ) {
            for ( auto &ins : bb ) {
                SliceInst( &ins, util ); 
            }
        }
        /*
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
        //assert( false && "Call" );

        AppendInstsByOperand( inst, GetRetValue( calledFunc ), util );
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
        Function *calledFunc = inst->getParent()->getParent();
        //assert( false && "Ret" );
        AppendInst( inst->getOperand( 0 ), inst, util );
        AppendInstsByOperand( inst->getOperand( 0 ), inst, util );
        AppendRetValue( calledFunc, inst->getOperand( 0 ) );
        break;
    }
    case Instruction::PHI :
    {
        assert( false && "PHI" );
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
    default:
        break;
    }
}

    void SetPointingValue( Value *key, Value *pointee )
    {
        if ( mBwPointingValue->empty() || mBwPointingValue->find( key ) == mBwPointingValue->end() ) {
            mBwPointingValue->emplace( key, pointee );
        }
        else {
            (*mBwPointingValue)[key] = pointee;
        }
        
    }

    Value* GetPointingValue( Value *key )
    {
        //assert( mBwPointingValue->find( key ) != mBwPointingValue->end() &&
        //        "Not Found Key in getPointingValue" );
        
        if ( key == nullptr || mBwPointingValue->find( key ) == mBwPointingValue->end() ) {
            return nullptr;
        }
        
       return mBwPointingValue->at( key );
    }

    Value* FindAlias( Value *v )
    {
        if ( v == nullptr || mBwAliasLists->empty() ) {
            return nullptr;
        }

        for ( auto it : *mBwAliasLists ) {
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
        if ( mBwAliasLists->find( key ) == mBwAliasLists->end() ) {
            mBwAliasLists->emplace( key, new vector<Value*> );
        } 

        mBwAliasLists->at( key )->push_back( v );
    }

    void AppendInstsByOperand( Value *result, Value *operand, UtilDef *util )
    {
        vector<Value*> tmp;
        map<Value*, vector<Value*>*>* resultMap;
        map<Value*, vector<Value*>*>* operandMap;
        assert( util != nullptr && "Util is nullptr" );
        
        if ( result->getValueID() == Value::BasicBlockVal ) {
            resultMap = mBwBlockLists;
        }
        else {
            resultMap = mBwInstLists;
        }
        if ( resultMap->find( result ) == resultMap->end() ) {
            if ( result->getValueID() == Value::InstructionVal ) {
                Instruction *inst = dyn_cast<Instruction>( result );
                errs() << inst->getParent()->getParent()->getName().str() << " " << result->getValueID() << " " << util->inst2idx( result ) << "\n";
            }
            assert( resultMap->find( result ) != resultMap->end() && "Not Found result" );
        }
        // assert( mBwInstLists->find( operand ) == mBwInstLists->end() && "Not Found operand" );

        if ( operand->getValueID() == Value::BasicBlockVal ) {
            operandMap = mBwBlockLists;
        }
        else {
            operandMap = mBwInstLists;
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

    void AppendInst( Value *key, Value *v, UtilDef *util )
    {
        map<Value*, vector<Value*>*>* target;
        
        if ( key->getValueID() == Value::BasicBlockVal ) {
            target = mBwBlockLists;
        }
        else {
            target = mBwInstLists;
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

    void AppendFindValue( Value *key, Value *v )
    {
        if ( mBwValueToFindLists->find( key ) == mBwValueToFindLists->end() ) {
            mBwValueToFindLists->emplace( key, new vector<Value*> );
            mBwValueToFindLists->at( key )->push_back( key );
        }
        mBwValueToFindLists->at( key )->push_back( v );
    }

    bool IsFindValue( Value *key, Value *v ) const
    {
        assert( mBwValueToFindLists->find( key ) != mBwValueToFindLists->end() && "Not found key" );

        for ( auto valueToFind : *mBwValueToFindLists->at( key ) ) {
            if ( valueToFind == v ) {
                return true;
            }
        }
        return false;
    }

    void AppendRetValue( Value *func, Value *ret )
    {
        mBwRetValues->emplace( func, ret );
    }

    Value* GetRetValue( Value *func )
    {
        assert( mBwRetValues->find( func ) != mBwRetValues->end() && "Not Found Ret Value" );
        return mBwRetValues->at( func );
    }

    void PrintAll( void ) const
    {
        UtilDef *util = new UtilDef;
        for ( auto it : *mBwInstLists ) {
            std::string name = it.first->getName().str();
            if ( !name.empty() ) {
                outs() << pasMsg( "VAR : " ) << name << "\n";
            }
            else {
                outs() << pasMsg( "VAR : " ) << "temp" << "\n";
            }
            Function *predFunc = nullptr;
            BasicBlock *predBB = nullptr;
            for ( auto value : *( it.second ) ) {
                Instruction *inst = dyn_cast<Instruction>( value );
                if ( predFunc != inst->getParent()->getParent() ) {
                    outs() << inst->getParent()->getParent()->getName().str() << ":\n";
                }
                if ( predBB != inst->getParent() ) {
                    outs() << inst->getParent()->getName().str() << ":\n";
                }
                outs() << util->inst2str( value ) << "\n";
                predBB = inst->getParent();
                predFunc = inst->getParent()->getParent();
            }
        }

        delete util;
    }

    void PrintAllBlocks( void ) const
    {
        UtilDef *util = new UtilDef;
        for ( auto it : *mBwBlockLists ) {
            std::string name = it.first->getName().str();
            if ( !name.empty() ) {
                outs() << pasMsg( "VAR : " ) << name << "\n";
            }
            else {
                outs() << pasMsg( "VAR : " ) << "temp" << "\n";
            }
            
            for ( auto value : *( it.second ) ) {
                
                if ( value->getValueID() == 20 ) {
                    outs() << value->getName().str() << "\n";
                }
                else {
                    Instruction *inst = dyn_cast<Instruction>( value );
                    
                    outs() << util->inst2str( value ) << "\n";
                }
            }
        }

        delete util;
    }

    bool isKey( Value *v )
    {
        if ( mBwInstLists->find( v ) == mBwInstLists->end() ) {
            return false;
        }

        return true;
    }
};

#endif