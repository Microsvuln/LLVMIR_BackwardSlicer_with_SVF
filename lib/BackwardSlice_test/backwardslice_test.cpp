#include "UtilDef.h"
#include "backwardslice_test.h"
#include "slice_test.h"

#include <llvm/IR/Instruction.h>

#include <iostream>



void BackwardSlice::BackwardSlicing( Function *func, map<Function*, int> *call_list )
{
    if( call_list->find( func ) == call_list->end() ) {
        call_list->emplace( func, 1 );
    }
    else {
        call_list->at( func ) ++;
    }
    for ( auto it : *call_list ) {
        if ( it.second >= 3 ) {
            return;
        }
    }

    outs() << func->getName().str() << ": for debug\n";
    IntraSlicing( func );
    //AppendBranchConditionInst( func );
    InterSlicing( func, call_list );
    outs() << "done " << func->getName().str() << ": for debug\n";
    
    // global variable과 관련된 명령어들을 모아놓을 테이블과 관련 로직 필요함.
    // 각 function별로 global variable 에 대한 slice가 끝났으므로 이를 모두 종합해서 모아주면 될 듯.
}

void BackwardSlice::IntraSlicing( Function *func )
{
    if ( _sliced_func_list->find( func ) != _sliced_func_list->end() ) {
        return ;
    }
    SliceUtil *newSliceUtil = new SliceUtil;
    _sliced_func_list->emplace( func, newSliceUtil );

    UtilDef *util = new UtilDef;
    SliceUtil *sliceUtil = _sliced_func_list->at( func );

    for ( auto it = func->arg_begin(); it != func->arg_end(); it ++ ) {
        sliceUtil->CreateListForValue( &(*it) );
    }

    for ( auto &bb : *func ) {
        for ( auto &inst : bb ) {
            if ( util->inst2str( &inst ).find( "llvm.dbg." ) != string::npos )
                    continue;
            sliceUtil->Slicing( &inst );
        }
    }
}

void BackwardSlice::AppendBranchConditionInst( Function *func )
{
    SliceUtil *sliceutil = _sliced_func_list->at( func );
    sliceutil->AppendBranchConditionInst();
}

void BackwardSlice::InterSlicing( Function *func, map<Function*, int> *call_list )
{
    UtilDef*    util        = new UtilDef;
    SliceUtil*  sliceutil   = _sliced_func_list->at( func );

    map <Value*, vector<Instruction*>*>* inter_sliced_list = sliceutil->GetInterSlicedList();
    for ( auto it : *sliceutil->GetSlicedList() ) {
        Value*                  value       = it.first;
        vector<Instruction*>*   inst_list   = it.second;
        vector<Instruction*>*   tmp_merge_list  = new vector<Instruction*>;

        for ( auto inst : *inst_list ) {
            tmp_merge_list->push_back( inst );
            outs() << " [DEBUG] " << util->inst2str( inst ) << "\n";
            
            // 1. Check call instruction or not
            if ( inst->getOpcode() == Instruction::Call ) {
                CallInst*   call_inst   = dyn_cast<CallInst>( inst );
                Value*      called_op   = sliceutil->GetHeadValue( call_inst->getCalledOperand() );
                Function*   called_func = nullptr;

                if ( called_op->getValueID() == Value::FunctionVal ) {
                    called_func = dyn_cast_or_null<Function>( called_op );
                }
                else if ( called_op->getValueID() == Value::ConstantExprVal ) {
                    ConstantExpr *constantexprvalue = dyn_cast<ConstantExpr>( called_op );
                    called_func = dyn_cast_or_null<Function>( constantexprvalue->getOperand( 0 ) );
                }

                if ( _ignore_func_list_for_interslice->find( called_func->getName().str() ) != _ignore_func_list_for_interslice->end() || 
                    called_func->size() == 0 ) {
                        outs() << "pass " << called_func->getName().str() << "\n";
                    continue;
                }

                if ( called_func == nullptr ) {
                    outs() << "assert : " << util->inst2str( inst ) << "\n";
                    assert( called_func != nullptr && "wrong function operand" );
                }


                // 2. Backward slice for called function
                BackwardSlicing( called_func, call_list );

                assert( _sliced_func_list->find( called_func ) != _sliced_func_list->end() );
                SliceUtil *called_func_util = _sliced_func_list->at( called_func );

                // 3. Merge results to caller
                for ( uint32_t i = 0; i < called_func->getNumOperands(); i ++ ) { // 가변함수 때문에 호출할 때 인자 갯수가 아닌, 함수 정의에 있는 arguement 갯수까지
                    Value *param = call_inst->getArgOperand( i );
                    Value *arg = called_func->getArg( i );
                    //Value *param_head_value = called_func_util->GetHeadValue( param );
 
                    if ( value == param ) {
                        vector<Instruction*> *param_inst_list = called_func_util->GetInterInstListByValue( arg );
                        if ( param_inst_list == nullptr ) {
                            param_inst_list = called_func_util->GetInstListByValue( arg );
                        }
                        for ( auto v : *param_inst_list ) {
                            tmp_merge_list->push_back( v );
                        }
                        break;
                    }
                }

                if ( !called_func->getReturnType()->isVoidTy() ) {
                    Value *return_value = called_func_util->GetReturnValue();
                    vector<Instruction*> *retval_inst_list = called_func_util->GetInterInstListByValue( called_func_util->GetHeadValue( return_value ) );
                    if ( retval_inst_list == nullptr ) {
                        retval_inst_list = called_func_util->GetInstListByValue( called_func_util->GetHeadValue( return_value ) );
                    }

                    for ( auto v : *retval_inst_list ) {
                        tmp_merge_list->push_back( v );
                    }
                }
            }
        }

        // Merge to inter_list
        inter_sliced_list->emplace( value, new vector<Instruction*> );
        inter_sliced_list->at( value ) = tmp_merge_list;
    }
}

void BackwardSlice::Print( Function *func, Value *value )
{
    outs() << "Func : " << func->getName() << "\n";
    _sliced_func_list->at( func )->PrintSliceResult( value );
}

void BackwardSlice::PrintByValueIdx( Function *func )
{
    int idx;
    _sliced_func_list->at( func )->PrintValueList();
    std::cin >> idx;
    _sliced_func_list->at( func )->PrintSliceResult( idx );
}