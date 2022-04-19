#include "slice_test.h"
#include "UtilDef.h"

#include <llvm/IR/Instructions.h>

#include <cassert>

vector<Instruction*>* SliceUtil::GetInstListByValue ( Value *value )
{
    if ( _sliced_insts_value_list->find( value ) == _sliced_insts_value_list->end() ) {
        outs()  << "assert : " //<< name << ", " 
                << _util->inst2str( value ) << "\n";
        assert( _sliced_insts_value_list->find( value ) != _sliced_insts_value_list->end() && "Value's list does not exist" );
    }
    
    return _sliced_insts_value_list->at( value );
}

vector<Instruction*>* SliceUtil::GetInterInstListByValue ( Value *value )
{
    if ( _inter_sliced_list->find( value ) == _inter_sliced_list->end() ) {
        //outs()  << "assert : " //<< name << ", " 
                //<< _util->inst2str( value ) << "\n";
        //assert( _inter_sliced_list->find( value ) != _inter_sliced_list->end() && "Value's list does not exist" );
        return nullptr;
    }
    
    return _inter_sliced_list->at( value );
}

map <Value*, vector<Instruction*>*>* SliceUtil::GetSlicedList ( void )
{
    return _sliced_insts_value_list;
}

map <Value*, vector<Instruction*>*>* SliceUtil::GetInterSlicedList ( void )
{
    return _inter_sliced_list;
}

Value* SliceUtil::GetReturnValue( void )
{
    return _return_value;
}

void SliceUtil::AppendBranchConditionInst( void )
{   
    for ( auto it : *_sliced_insts_value_list ) {
        BasicBlock *prev_block = nullptr;
        for ( auto inst : *it.second ) {

            BasicBlock *current_block = inst->getParent();
            if ( prev_block == nullptr ) {
                prev_block = current_block;
                continue;
            }
            if ( current_block != prev_block ) {
                outs() << SVF::SVFUtil::pasMsg("[DEBUG] ") << current_block->getName() + "\n";
                MergeForBranch( it.first, current_block );
                prev_block = current_block;
            }

        }
    }
}

void SliceUtil::PrintSliceResult( Value *value ) const
{
    BasicBlock *prev_block = nullptr;
    Function *prev_func = nullptr;

    assert( _inter_sliced_list->find( value ) != _inter_sliced_list->end() );

    for ( auto inst : *_inter_sliced_list->at( value ) ) {
        Function *cur_func = inst->getFunction();
        if ( cur_func != prev_func ) {
            outs() << "--------------------------------------------------\n";
            prev_func = cur_func;
        }

        BasicBlock *cur_block = inst->getParent();
        if ( cur_block != prev_block ) {
            outs() << cur_block->getName() << ":\n";
            prev_block = cur_block;
        }
        outs() << _util->inst2str( inst ) << "\n";

    }
}

void SliceUtil::PrintSliceResult( int idx ) const
{
    outs() << "by index\n";
    PrintSliceResult( (*_values)[idx] );
}

void SliceUtil::PrintValueList( void ) const
{
    int i = 0;
    for ( auto value : *_values ) {
        assert( _inter_sliced_list->find( value ) != _inter_sliced_list->end() );
        if ( _inter_sliced_list->at( value )->empty() ) {
            i ++;
            continue;
        }
        outs() << i << " : ";
        if ( value->getName().empty() ) {
            outs() << _util->inst2str( value );
        }
        else {
            outs() << value->getName();
        }

        if ( _return_value == value ) {
            outs() << " (return value)";
        }

        outs() << "\n";
        i ++;
    }
}

bool SliceUtil::CreateListForValue( Value *value )
{
    if ( _sliced_insts_value_list->find( value ) != _sliced_insts_value_list->end() ) {
        return false;
    }
    _values->push_back( value ); 
    _sliced_insts_value_list->emplace( value, new vector<Instruction*> );
    return true;
}

bool SliceUtil::CreateListForBlock( BasicBlock *bb )
{
    if ( _sliced_insts_block_list->find( bb ) != _sliced_insts_block_list->end() ) {
        return false;
    }

    _sliced_insts_block_list->emplace( bb, new vector<Instruction*> );
    return true;
}

void SliceUtil::AppendInstForValue( Value *value_dst, Instruction *inst )
{
    if ( _sliced_insts_value_list->find( value_dst ) == _sliced_insts_value_list->end() ) {
        outs() << "assert : " << _util->inst2str( value_dst ) << "\n";
        assert( _sliced_insts_value_list->find( value_dst ) != _sliced_insts_value_list->end() && "Value's list does not exist");
    }

    vector<Instruction*> *inst_list = _sliced_insts_value_list->at( value_dst );

    for ( auto it = inst_list->begin(); it != inst_list->end(); it ++ ) {
        if ( _util->inst2idx( *it ) == _util->inst2idx( inst ) ) {
            return;
        }
        if ( _util->inst2idx( *it ) > _util->inst2idx( inst ) ) {
            inst_list->insert( it, inst );
            return;
        }
    }

    inst_list->push_back( inst );
}

void SliceUtil::AppendInstForBlock( BasicBlock *bb_dst, Instruction *inst )
{
    assert( _sliced_insts_block_list->find( bb_dst ) != _sliced_insts_block_list->end() && "Block's list does not exist");

    vector<Instruction*> *inst_list = _sliced_insts_block_list->at( bb_dst );

    if ( inst_list->empty() ) {
        inst_list->push_back( inst );
        return;
    }

    for ( auto it = inst_list->begin(); it != inst_list->end(); it ++ ) {
        if ( _util->inst2idx( *it ) == _util->inst2idx( inst ) ) {
            return;
        }
        if ( _util->inst2idx( *it ) > _util->inst2idx( inst ) ) {
            inst_list->insert( it, inst );
            return;
        }
    }
}

void SliceUtil::Merge( Value *value_dst, Value *value_src )
{
    assert( _sliced_insts_value_list->find( value_dst ) != _sliced_insts_value_list->end() && "Value_dst's list does not exist");
    assert( _sliced_insts_value_list->find( value_src ) != _sliced_insts_value_list->end() && "Value_src's list does not exist");

    vector<Instruction*> *tmp_list = new vector<Instruction*>;
    vector<Instruction*> *dst_list = _sliced_insts_value_list->at( value_dst );
    vector<Instruction*> *src_list = _sliced_insts_value_list->at( value_src );

    auto dst_it = dst_list->begin();
    auto src_it = src_list->begin();

    while ( dst_it != dst_list->end() && src_it != src_list->end() ) {
        if ( _util->inst2idx( *dst_it ) == _util->inst2idx( *src_it ) ) {
            tmp_list->push_back( *dst_it );
            dst_it ++;
            src_it ++;
        }
        else if ( _util->inst2idx( *dst_it ) < _util->inst2idx( *src_it ) ) {
            tmp_list->push_back( *dst_it );
            dst_it ++;
        }
        else {
            tmp_list->push_back( *src_it );
            src_it ++;
        }
    }

    while ( dst_it != dst_list->end() ) {
        tmp_list->push_back( *dst_it );
        dst_it ++;
    }

    while ( src_it != src_list->end() ) {
        tmp_list->push_back( *src_it );
        src_it ++;
    }

    dst_list->clear();
    for ( auto inst : *tmp_list ) {
        dst_list->push_back( inst );
    }
}

void SliceUtil::MergeForBranch( Value *value_dst, BasicBlock *bb_src )
{
    if ( _sliced_insts_block_list->find( bb_src ) == _sliced_insts_block_list->end() || 
        _sliced_insts_value_list->find( value_dst ) == _sliced_insts_value_list->end() ) {
            outs() << "dst : " << _util->inst2str( value_dst ) << ", bb : " << bb_src->getName() << "\n";
            assert( _sliced_insts_value_list->find( value_dst ) != _sliced_insts_value_list->end() && "Value_dst's list does not exist" );
            assert( _sliced_insts_block_list->find( bb_src ) != _sliced_insts_block_list->end() && "Value_src's list does not exist" );
    }

    vector<Instruction*> *tmp_list = new vector<Instruction*>;
    vector<Instruction*> *dst_list = _sliced_insts_value_list->at( value_dst );
    vector<Instruction*> *src_list = _sliced_insts_block_list->at( bb_src );

    auto dst_it = dst_list->begin();
    auto src_it = src_list->begin();

    while ( dst_it != dst_list->end() && src_it != src_list->end() ) {
        if ( _util->inst2idx( *dst_it ) == _util->inst2idx( *src_it ) ) {
            tmp_list->push_back( *dst_it );
            dst_it ++;
            src_it ++;
        }
        else if ( _util->inst2idx( *dst_it ) < _util->inst2idx( *src_it ) ) {
            tmp_list->push_back( *dst_it );
            dst_it ++;
        }
        else {
            tmp_list->push_back( *src_it );
            src_it ++;
        }
    }

    while ( dst_it != dst_list->end() ) {
        tmp_list->push_back( *dst_it );
        dst_it ++;
    }

    while ( src_it != src_list->end() ) {
        tmp_list->push_back( *src_it );
        src_it ++;
    }

    dst_list->clear();
    for ( auto inst : *tmp_list ) {
        dst_list->push_back( inst );
    }
}

void SliceUtil::AppendPointerList( Value *pointer, Value *pointee )
{
    if ( _pointer_list_table->find( pointer ) == _pointer_list_table->end() ) {
        _pointer_list_table->emplace( pointer, pointee );
        return;
    }
    _pointer_list_table->at( pointer ) = pointee;
}

Value *SliceUtil::GetPointingValue( Value *value )
{
    if ( _pointer_list_table->find( value ) == _pointer_list_table->end() ) {
        return nullptr;
    }

    return _pointer_list_table->at( value );
    //assert( false && "Not found pointing value" );
}

Value *SliceUtil::GetPointerValue( Value *value ) 
{
    for ( auto it : *_pointer_list_table ) {
        if ( it.second == value ) {
            return it.first;
        }
    }

    return nullptr;
}

bool SliceUtil::CreateAliasList( Value *value )
{
    if ( _alias_list->find( value ) != _alias_list->end() ) {
        return false;
    }

    _alias_list->emplace( value, new vector<Value*> );
    return true;
}

void SliceUtil::AppendAliasList( Value *head_value, Value *value )
{
    assert( _alias_list->find( head_value ) != _alias_list->end() && "head_value's list does not exist");

    _alias_list->at( head_value )->push_back( value );
}

Value *SliceUtil::GetAliasHeadValue( Value *value )
{
    for ( auto it : *_alias_list ) {
        for ( auto alias_value : *( it.second ) ) {
            if ( alias_value == value ) {
                return it.first;
            }
        }
    }

    return nullptr;
    //assert( false && "Not found alias head_value" );
}

string SliceUtil::MakeHash( GetElementPtrInst *gepinst, bool is_alias )
{
    string hash;

    Value *object = gepinst->getOperand( 0 );
    Value *head_value = GetAliasHeadValue( object );

    if ( is_alias ) {
        object = GetAliasHeadValue( object );
    }

    if ( head_value == nullptr ) {
        hash += to_string( (uint64_t)object );
    }
    else {
        hash += to_string( (uint64_t)head_value );
    }

    for ( uint32_t i = 1; i < gepinst->getNumOperands(); i ++ ) {
        Value *op = gepinst->getOperand( i );
        if ( op->getValueID() == Value::ConstantIntVal ) {
            ConstantInt *constint = dyn_cast<ConstantInt>( op );
            hash += to_string( constint->getZExtValue() );
        }
        else {
            hash += to_string( (uint64_t)op );
        }
        
    }

    return hash;
}

bool SliceUtil::CreateElementList( string hash, GetElementPtrInst *gepinst )
{
    if ( _element_list->find( hash ) != _element_list->end() ) {
        return false;
    }

    _element_list->emplace( hash, new vector<GetElementPtrInst*> );
    _element_list->at( hash )->push_back( gepinst );
    _head_element_list->emplace( hash, gepinst );
    return true;
}

void SliceUtil::AppendElementList( string hash, GetElementPtrInst *gepinst )
{
    assert( _element_list->find( hash ) != _element_list->end() && "element's list does not exist");

    _element_list->at( hash )->push_back( gepinst );
}

GetElementPtrInst *SliceUtil::GetHeadElement( string hash )
{
    if ( _head_element_list->find( hash ) == _head_element_list->end() ) {
        return nullptr;
    }
    return _head_element_list->at( hash );
}

Value* SliceUtil::GetHeadValue( Value* value )
{
    Value* aliasHeadValue = nullptr;
    GetElementPtrInst* elementHeadValue = nullptr;

    aliasHeadValue = GetAliasHeadValue( value );

    if ( value->getValueID() == Value::InstructionVal + Instruction::GetElementPtr ) {
        bool is_alias = true;
        if ( aliasHeadValue == nullptr )
            is_alias = false;
        string hash = MakeHash( dyn_cast<GetElementPtrInst>( value ), is_alias );
        elementHeadValue = GetHeadElement( hash );
    }

    if ( aliasHeadValue != nullptr && elementHeadValue != nullptr ) {
        assert( false );
    }
    else if ( aliasHeadValue != nullptr ) {
        return aliasHeadValue;
    }
    else if ( elementHeadValue != nullptr ) {
        return elementHeadValue;
    }
    return value;
}

bool SliceUtil::IsIgnoreFunc( Instruction *inst ) {
    assert( inst->getOpcode() == Instruction::Call );
    string inst_str = _util->inst2str( inst );
    for ( auto func_name : *_ignore_func_list ) {
        if ( inst_str.find( func_name ) != string::npos ) {
            return true;
        }
    }

    return false;
}

void SliceUtil::Slicing( Instruction *inst ) {
    outs() << SVF::SVFUtil::pasMsg( _util->inst2str( inst ) ) << "\n";
    switch ( inst->getOpcode() ) {

    case Instruction::Alloca :
    {
        // Just create list
        CreateListForValue( inst );
        break;
    }
    case Instruction::GetElementPtr :
    {
        // "GetElementPtr" instruction returns pointer.
        // If the hash does not found, create element list
        // and create instrution list.
        // If the hash is existed, append element list 
        // and if head element is in pointer list, append pointer list
        // and merge instructions to head elem list.
        GetElementPtrInst *gepinst = dyn_cast<GetElementPtrInst>( inst );
        Value *object = inst->getOperand( 0 );
        Value *object_head_value = GetHeadValue( object );

        // Check object is temporal value
        if ( object_head_value == object ) {
            string hash = MakeHash( gepinst, false );

            // Check already existed member variable
            if ( CreateElementList( hash, gepinst ) ) {
                CreateListForValue( inst );
                AppendInstForValue( inst, inst );
            }
            else {
                GetElementPtrInst *head_elem = GetHeadElement( hash );
                AppendElementList( hash, gepinst );
                AppendInstForValue( head_elem, inst );
            }
        }
        else {
            string hash = MakeHash( gepinst, true );
            // Check already existed member variable
            if ( CreateElementList( hash, gepinst ) ) {
                CreateListForValue( inst );
                AppendInstForValue( inst, inst );
                Merge( inst, object_head_value );
            }
            else {
                GetElementPtrInst *head_elem = GetHeadElement( hash );
                AppendElementList( hash, gepinst );
                AppendInstForValue( head_elem, inst );
                Merge( head_elem, object_head_value );
            }
        }

        break;
    }
    case Instruction::Store :
    {
        Value *value = inst->getOperand( 0 );
        Value *var = inst->getOperand( 1 );
        Value *value_head = GetHeadValue( value );
        Value *var_head = GetHeadValue( var );

        if ( _sliced_insts_value_list->find( var_head ) == _sliced_insts_value_list->end() ) {
            CreateListForValue( var_head );
        }

        if ( var->getType()->isPointerTy() ) {
            AppendPointerList( var_head, value_head );
        }

        if ( _sliced_insts_value_list->find( value_head ) != _sliced_insts_value_list->end() ) {
            Merge( var_head, value_head );
        }
        AppendInstForValue( var_head, inst );

        break;
    }
    
    case Instruction::Load :
    {
        Value *var = inst->getOperand( 0 );
        Value *var_head_value = GetHeadValue( var );

        if ( var_head_value->getValueID() == Value::GlobalVariableVal ) {
            CreateListForValue( var_head_value );
        }

        Value *pointing_value = GetPointingValue( var_head_value );
        if ( pointing_value != nullptr ) {
            CreateAliasList( pointing_value );
            AppendAliasList( pointing_value, inst );
            CreateListForValue( pointing_value );
            AppendInstForValue( pointing_value, inst );
            Merge( pointing_value, var_head_value );
        }
        else {
            AppendPointerList( var_head_value, inst );
            CreateListForValue( inst );
            AppendInstForValue( inst, inst );
            Merge( inst, var_head_value );
        }

        break;
    }
    
    // term ops
    case Instruction::Br :
    case Instruction::Switch :
    {
        Value *op1 = inst->getOperand( 0 );
        //assert( false && "branch" );
        if ( op1->getValueID() == Value::BasicBlockVal ) {
            CreateListForBlock( dyn_cast<BasicBlock>( op1 ) );
            AppendInstForBlock( dyn_cast<BasicBlock>( op1 ), inst );
        }
        else {
            for ( uint32_t i = 1; i < inst->getNumOperands(); i ++ ) {
                Value *op = inst->getOperand( i );
                BasicBlock *bb = dyn_cast<BasicBlock>( op );
                CreateListForBlock( bb );
                AppendInstForBlock( bb, inst );
                Instruction *condition_var = dyn_cast_or_null<Instruction>( op1 );
                if ( condition_var != nullptr ) {
                    AppendInstForBlock( bb, condition_var );
                }
                
            }
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
    // atomic
    case Instruction::AtomicRMW :
    {
        Value *op1 = inst->getOperand( 0 );
        Value *op1_head_value = GetHeadValue( op1 );
        Value *op2 = inst->getOperand( 1 );
        Value *op2_head_value = GetHeadValue( op2 );
        
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );
        if ( _sliced_insts_value_list->find( op1_head_value ) != _sliced_insts_value_list->end() ) {
            Merge( inst, op1_head_value );
        }
        if ( _sliced_insts_value_list->find( op2_head_value ) != _sliced_insts_value_list->end() ) {
            Merge( inst, op2_head_value );
        }
        
        break;
    }

    // Unary operator
    case Instruction::FNeg:
    {
        Value *op = inst->getOperand( 0 );
        Value *head_value = GetHeadValue( op );
        
        CreateAliasList( head_value );
        AppendAliasList( head_value, inst );

        break;
    }
    
    case Instruction::Select :
    {
        //assert( false && "Select" );

        // For continuos backward slice,
        // this instruction is appended to last of selected value's inst list.
        Value *op1_head_value = GetHeadValue( inst->getOperand( 0 ) );
        Value *op2_head_value = GetHeadValue( inst->getOperand( 1 ) );
        if ( _sliced_insts_value_list->find( op1_head_value ) != _sliced_insts_value_list->end() )
            AppendInstForValue( op1_head_value, inst );
        if ( _sliced_insts_value_list->find( op2_head_value ) != _sliced_insts_value_list->end() )
            AppendInstForValue( op2_head_value, inst );

        // And create new list.
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );
        if ( _sliced_insts_value_list->find( op1_head_value ) != _sliced_insts_value_list->end() )
            Merge( inst, op1_head_value );
        if ( _sliced_insts_value_list->find( op2_head_value ) != _sliced_insts_value_list->end() )
            Merge( inst, op2_head_value );
        break;
    }
    
    case Instruction::AtomicCmpXchg :
    {
        assert( false && "AtomicCmpXchg" );
        break;
    }

    case Instruction::Call :
    {
        if ( IsIgnoreFunc( inst ) ) {
            break;
        }
        //assert( false && "Call" );
        CallInst*   call_inst   = dyn_cast<CallInst>( inst );
        Value*      called_op   = GetHeadValue( call_inst->getCalledOperand() );
        Function*   called_func = nullptr;

        if ( called_op->getValueID() == Value::FunctionVal ) {
            called_func = dyn_cast_or_null<Function>( called_op );
        }
        else if ( called_op->getValueID() == Value::ConstantExprVal ) {
            ConstantExpr *constantexprvalue = dyn_cast<ConstantExpr>( called_op );
            called_func = dyn_cast_or_null<Function>( constantexprvalue->getOperand( 0 ) );
        }

        if ( called_func == nullptr ) {
            //outs() << "assert : " << _util->inst2str( inst ) << "\n";
            //assert( called_func != nullptr && "wrong function operand" );
            break;
        }


        Type* called_func_return_type = called_func->getReturnType();
        // If called function has return value, merge params inst list and call inst
        if ( !called_func_return_type->isVoidTy() ) {
            CreateListForValue( inst );
            AppendInstForValue( inst, inst );
            for ( uint32_t i = 0; i < inst->getNumOperands() - 1; i ++ ) {
                Value *head_value = GetHeadValue( inst->getOperand( i ) );
                if ( _sliced_insts_value_list->find( head_value ) != _sliced_insts_value_list->end() )
                    Merge( inst, head_value );
            }
        }

        // Check all params and if the value is the same as the param, append call instruction to list.
        for ( uint32_t i = 0; i < call_inst->getNumArgOperands(); i ++ ) {
            Value *param_head_value = GetHeadValue( call_inst->getOperand( i ) );
            for ( auto it : *_sliced_insts_value_list ) {
                Value *value = it.first;
                if ( value == param_head_value ) {
                    AppendInstForValue( value, inst );
                    break;
                }
            }
        }
        
        break;
    }
    case Instruction::ShuffleVector :
    {
        // assert( false && "ShuffleVector" );
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );

        Value *op1 = inst->getOperand( 0 );
        Value *op1_head_value = GetHeadValue( op1 );
        if ( _sliced_insts_value_list->find( op1_head_value ) != _sliced_insts_value_list->end() ) {
            Merge( inst, op1_head_value );
        }

        Value *op2 = inst->getOperand( 1 );
        Value *op2_head_value = GetHeadValue( op2 );
        if ( _sliced_insts_value_list->find( op2_head_value ) != _sliced_insts_value_list->end() ) {
            Merge( inst, op2_head_value );
        }
        break;
    }
    case Instruction::Ret :
    {  
        //assert( false && "Ret" );
        if ( inst->getNumOperands() > 0 && !( inst->getFunction()->getReturnType()->isVoidTy() ) ) {
            _return_value = GetHeadValue( inst->getOperand( 0 ) );
            CreateListForValue( _return_value );
            AppendInstForValue( _return_value, inst );
        }
        break;
    }
    case Instruction::PHI :
    {
        //assert( false && "PHI" );

        // For continuous backward slice,
        // this instruction is appended to last of selected value's inst list.
        Value *op1_head_value = GetHeadValue( inst->getOperand( 0 ) );
        Value *op2_head_value = GetHeadValue( inst->getOperand( 1 ) );
        if ( _sliced_insts_value_list->find( op1_head_value ) != _sliced_insts_value_list->end() ) {
            AppendInstForValue( op1_head_value, inst );
        }
        if ( _sliced_insts_value_list->find( op2_head_value ) != _sliced_insts_value_list->end() ) {
            AppendInstForValue( op2_head_value, inst );
        }

        // And create new list.
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );
        if ( _sliced_insts_value_list->find( op1_head_value ) != _sliced_insts_value_list->end() )
            Merge( inst, op1_head_value );
        if ( _sliced_insts_value_list->find( op2_head_value ) != _sliced_insts_value_list->end() )
            Merge( inst, op2_head_value );
        break;
    }
    case Instruction::InsertElement :
    {
        //assert( false && "InsertElement" );
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );

        Value *element = inst->getOperand( 1 );
        Value *element_head_value = GetHeadValue( element );
        if ( _sliced_insts_value_list->find( element_head_value ) != _sliced_insts_value_list->end() ) {
            Merge( inst, element_head_value );
        }
        break;
    }
    case Instruction::InsertValue :
    {
        assert( false && "InsertValue" );
        break;
    }
    case Instruction::Fence :
    {
        assert( false && "Fence" );
        break;
    }
    case Instruction::ExtractElement :
    {
        assert( false && "ExtractElement" );
        break;
    }
    case Instruction::ExtractValue :
    {
        assert( false && "ExtractValue" );
        break;
    }
    case Instruction::LandingPad :
    {
        assert( false && "LandingPad" );
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
        //assert( false && "casting op" ); 
        CreateAliasList( GetHeadValue( inst->getOperand( 0 ) ) );
        AppendAliasList( GetHeadValue( inst->getOperand( 0 ) ), inst );
        AppendInstForValue( GetHeadValue( inst->getOperand( 0 ) ), inst );
        break;
    }

    // Just Pass
    case Instruction::Unreachable :
    {
        break;
    }

    default:
        //outs() << "assert : " << inst->getOpcodeName() << "\n";
        //outs() << "assert : " << _util->inst2str( inst ) << "\n";
        assert( false && "Not handled instruction" );
        break;
    }
    //ForDebugPrint();
}

void SliceUtil::ForDebugPrint( void )
{
    outs() << "|\t\t|\n";
    for ( auto it : *_sliced_insts_value_list ) {
        outs() << (it.first)->getName() << "\n";
        for ( auto i : *it.second ) {
            outs() << _util->inst2str( i ) << "\n";
        }
    }
}