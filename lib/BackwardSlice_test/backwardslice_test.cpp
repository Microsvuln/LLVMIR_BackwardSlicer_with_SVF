#include "UtilDef.h"
#include "backwardslice_test.h"
#include "slice_test.h"

#include <llvm/IR/Instruction.h>

#include <iostream>

void BackwardSlice::BackwardSlicingMain( Function *func, map<Function*, int> *call_list )
{
    if( call_list->find( func ) == call_list->end() ) {
        call_list->emplace( func, 1 );
    }
    else {
        call_list->at( func ) ++;
    }

    //outs() << func->getName().str() << ": for debug\n";
    IntraSlicing( func );
    _sliced_func_list->at( func )->PrintValueList();
    int idx;
    std::cin >> idx;
    Value *target_value = _sliced_func_list->at( func )->GetValueByIndex( idx );
    //AppendBranchConditionInst( func );
    //InterSlicing( func, call_list );
    InterSlicingByValue( func, target_value, call_list );
    //outs() << "done " << func->getName().str() << ": for debug\n";

    call_list->at( func ) --;
    
    // global variable과 관련된 명령어들을 모아놓을 테이블과 관련 로직 필요함.
    // 각 function별로 global variable 에 대한 slice가 끝났으므로 이를 모두 종합해서 모아주면 될 듯.
}

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
            call_list->at( func ) --;
            return;
        }
    }

    //outs() << func->getName().str() << ": for debug\n";
    IntraSlicing( func );
    //AppendBranchConditionInst( func );
    InterSlicing( func, call_list );
    //outs() << "done " << func->getName().str() << ": for debug\n";

    call_list->at( func ) --;
    
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

    // Slice twice for loop
    for ( int i=0; i<2; i++ ) {
        for ( auto &bb : *func ) {
            for ( auto &inst : bb ) {
                if ( dyn_cast_or_null<DbgInfoIntrinsic>( &inst ) != nullptr ) {
                    continue;
                }
                /*
                if ( inst.getOpcode() == Instruction::Call ) {
                    CallInst *callinst = dyn_cast<CallInst>( &inst );
                    Function *called_func = callinst->getCalledFunction();
                    if ( called_func != nullptr && called_func->size() == 0 && called_func->getName()  ) {
                        continue;
                    }
                }
                
                if ( util->inst2str( &inst ).find( "llvm.dbg." ) != string::npos )
                        continue;
                */
                sliceUtil->Slicing( &inst );
            }
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
            //outs() << " [DEBUG] " << util->inst2str( inst ) << "\n";
            
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
                        //outs() << "pass " << called_func->getName().str() << "\n";
                    continue;
                }

                if ( called_func == nullptr ) {
                    outs() << "assert : " << util->inst2str( inst ) << "\n";
                    assert( called_func != nullptr && "wrong function operand" );
                }


                // 2. Backward slice for called function
                BackwardSlicing( called_func, call_list );

                
                /*
                bool is_called_more_than_three_times = false;
                for ( auto it : *call_list ) {
                    if ( it.second >= 3 ) {
                        is_called_more_than_three_times = true;
                        break;
                    }
                }
                if ( is_called_more_than_three_times ) {
                    outs() << "Called more than three times..\n";
                    continue;
                }
                if ( _sliced_func_list->find( called_func ) == _sliced_func_list->end() ) {
                    IntraSlicing( called_func );
                }
                */
                
                
                assert( _sliced_func_list->find( called_func ) != _sliced_func_list->end() );
                SliceUtil *called_func_util = _sliced_func_list->at( called_func );

                // 3. Merge results to caller
                for ( uint32_t i = 0; i < called_func->getNumOperands(); i ++ ) { // 가변함수 때문에 호출할 때 인자 갯수가 아닌, 함수 정의에 있는 arguement 갯수까지
                    Value *param = call_inst->getOperand( i );
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
        inter_sliced_list->emplace( value, tmp_merge_list );
    }
}

void BackwardSlice::InterSlicingByValue( Function *func, Value* target_value, map<Function*, int> *call_list )
{
    UtilDef*    util        = new UtilDef;
    SliceUtil*  sliceutil   = _sliced_func_list->at( func );

    map <Value*, vector<Instruction*>*>*    inter_sliced_list   = sliceutil->GetInterSlicedList();
    vector<Instruction*>*                   inst_list           = sliceutil->GetInstListByValue( target_value );
    vector<Instruction*>*                   tmp_merge_list      = new vector<Instruction*>;

    for ( auto inst : *inst_list ) {
        tmp_merge_list->push_back( inst );
        //outs() << " [DEBUG] " << util->inst2str( inst ) << "\n";
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
                    outs() << "pass(size0) " << called_func->getName().str() << "\n";
                continue;
            }

            if ( called_func == nullptr ) {
                //outs() << "assert : " << util->inst2str( inst ) << "\n";
                assert( called_func != nullptr && "wrong function operand" );
            }

            // 2. check calling more than 3 times
            if( call_list->find( called_func ) == call_list->end() ) {
                call_list->emplace( called_func, 1 );
            }
            else {
                call_list->at( called_func ) ++;  
            }

            bool is_called_3times = false;
            for ( auto it : *call_list ) {
                if ( it.second >= 3 ) {
                    is_called_3times = true;
                    break;
                }
            }
            if ( is_called_3times ) {
                //outs() << "pass(3times) " << called_func->getName().str() << "\n";
                call_list->at( called_func ) --;
                continue;
            }

            // 3. Intraslice for called function
            
            IntraSlicing( called_func );
            
            SliceUtil *called_func_util = _sliced_func_list->at( called_func );

            // 4. Interslice for relative with params and return value
            for ( uint32_t i = 0; i < call_inst->getNumArgOperands(); i ++ ) { // 가변함수 때문에 호출할 때 인자 갯수가 아닌, 함수 정의에 있는 arguement 갯수까지
                Value *param = call_inst->getOperand( i );
                Value *arg = called_func->getArg( i );

                //outs() << target_value->getName() << " : " << param->getName() << "\n";
                if ( target_value == param ) {
                    //outs() << "In! " << target_value->getName() << " : " << param->getName() << "\n";
                    InterSlicingByValue( called_func, arg, call_list );
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
                InterSlicingByValue( called_func, return_value, call_list );
                vector<Instruction*> *retval_inst_list = called_func_util->GetInterInstListByValue( called_func_util->GetHeadValue( return_value ) );
                if ( retval_inst_list == nullptr ) {
                    retval_inst_list = called_func_util->GetInstListByValue( called_func_util->GetHeadValue( return_value ) );
                }

                for ( auto v : *retval_inst_list ) {
                    tmp_merge_list->push_back( v );
                }
            }
            call_list->at( func ) --;
        }
    }

    // Merge to inter_list
    inter_sliced_list->emplace( target_value, tmp_merge_list );
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

void BackwardSlice::uorbtest ( Function *func )
{
    bool has = false;
    
    for ( auto &bb : *func ) {
        for ( auto &inst : bb ) {

            CallInst *callinst = dyn_cast_or_null<CallInst>( &inst );
            if ( callinst != nullptr ) {
                Value *called_op = callinst->getCalledOperand();
                Function *called_func = dyn_cast_or_null<Function>( called_op );
                if ( called_func == nullptr ) {
                    continue;
                }
                string func_name = called_func->getName().str();

                
                if ( ( func_name.find( "update" ) != string::npos 
                    || func_name.find( "copy" ) != string::npos )
                    && func_name.find( "Param" ) == string::npos
                    && func_name.find( "Block" ) == string::npos/*
                    && func_name.find( "uORB" ) != string::npos
                    && func_name.find( "Subscription" ) == string::npos
                    && func_name.find( "available" ) == string::npos
                    && func_name.find( "orb_publish" ) == string::npos
                    && func_name.find( "DeviceNode" ) == string::npos
                    && func_name.find( "CameraTrigger" ) == string::npos
                    && func_name.find( "MixingOutput" ) == string::npos
                    && func_name.find( "systemlib" ) == string::npos */
                    ) {
                    if ( has == false ) {
                        const char *demangled = _util->Demangle( func->getName().str() );
                        if ( demangled == nullptr ) {
                            demangled = "NULL";
                        }
                        outs() << SVF::SVFUtil::pasMsg( func->getName().str() ) << SVF::SVFUtil::pasMsg( " : " ) << SVF::SVFUtil::pasMsg( demangled ) << "\n";
                        has = true;
                    }
                    const char *demangled = _util->Demangle( func_name );
                    if ( demangled == nullptr ) {
                        demangled = "NULL";
                    }
                    outs() << "  " << _util->inst2str( &inst ) << "\n" << "  " << demangled << "\n";
                }
            }
        }
    }
}

void BackwardSlice::uorbpubtest ( Function *func )
{
    bool has = false;
    
    for ( auto &bb : *func ) {
        for ( auto &inst : bb ) {
            CallInst *callinst = dyn_cast_or_null<CallInst>( &inst );
            if ( callinst != nullptr ) {
                Value *called_op = callinst->getCalledOperand();
                Function *called_func = dyn_cast_or_null<Function>( called_op );
                if ( called_func == nullptr ) {
                    continue;
                }
                string func_name = called_func->getName().str();

                if ( ( func_name.find( "update" ) != string::npos 
                    || func_name.find( "publish" ) != string::npos )
                    && func_name.find( "uORB" ) != string::npos
                    && func_name.find( "Subscription" ) == string::npos
                    && func_name.find( "available" ) == string::npos
                    && func_name.find( "orb_publish" ) == string::npos
                    && func_name.find( "DeviceNode" ) == string::npos
                /*  && func_name.find( "Param" ) == string::npos
                    && func_name.find( "Block" ) == string::npos
                    && func_name.find( "CameraTrigger" ) == string::npos
                    && func_name.find( "MixingOutput" ) == string::npos
                    && func_name.find( "systemlib" ) == string::npos */
                    ) {
                    if ( has == false ) {
                        const char *demangled = _util->Demangle( func->getName().str() );
                        if ( demangled == nullptr ) {
                            demangled = "NULL";
                        }
                        outs() << SVF::SVFUtil::pasMsg( func->getName().str() ) << SVF::SVFUtil::pasMsg( " : " ) << SVF::SVFUtil::pasMsg( demangled ) << "\n";
                        has = true;
                    }

                    const char *demangled = _util->Demangle( func_name );
                    string demangled_str;
                    if ( demangled == nullptr ) {
                        demangled_str = "NULL";
                    }
                    else { 
                        demangled_str = demangled;
                    }

                    string topic_struct;
                    bool is_topic_str = false;
                    for ( auto c : demangled_str ) {
                        if ( c == ',' || c == '>' ) {
                            break;
                        }

                        if ( is_topic_str ) {
                            topic_struct += c;
                        }
                        
                        if ( c == '<') {
                            is_topic_str = true;
                        }
                    }

                    string topic = topic_struct.substr( 0, topic_struct.size() - 2 );
                    outs() << "  " << _util->inst2str( &inst ) << "\n" << "  " << demangled << "\n";
                    outs() << "topic : " << topic << "\n";
                }
            }
        }
    }
}