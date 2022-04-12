#include "slice_test.h"
#include "UtilDef.h"

#include <llvm/IR/Instructions.h>

#include <cassert>

bool SliceUtil::CreateListForValue( Value *value )
{
    if ( _sliced_insts_value_list->find( value ) == _sliced_insts_value_list->end() ) {
        return false;
    }

    _sliced_insts_value_list->emplace( value, new vector<Value*> );
    return true;
}

bool SliceUtil::CreateListForBlock( BasicBlock *bb )
{
    if ( _sliced_insts_block_list->find( bb ) == _sliced_insts_block_list->end() ) {
        return false;
    }

    _sliced_insts_block_list->emplace( bb, new vector<Value*> );
    return true;
}

void SliceUtil::AppendInstForValue( Value *value_dst, Instruction *inst )
{
    assert( _sliced_insts_value_list->find( value_dst ) != _sliced_insts_value_list->end() && "Value's list does not exist");

    _sliced_insts_value_list->at( value_dst )->push_back( inst );
}

void SliceUtil::AppendInstForBlock( BasicBlock *bb_dst, Instruction *inst )
{
    assert( _sliced_insts_block_list->find( bb_dst ) != _sliced_insts_block_list->end() && "Block's list does not exist");

    _sliced_insts_block_list->at( bb_dst )->push_back( inst );
}

void SliceUtil::Merge( Value *value_dst, Value *value_src )
{
    assert( _sliced_insts_value_list->find( value_dst ) != _sliced_insts_value_list->end() && "Value_dst's list does not exist");
    assert( _sliced_insts_value_list->find( value_src ) != _sliced_insts_value_list->end() && "Value_src's list does not exist");

    UtilDef *util = new UtilDef;
    vector<Instruction*> *tmp_list = new vector<Instruction*>;
    vector<Instruction*> *dst_list = _sliced_insts_value_list->at( value_dst );
    vector<Instruction*> *src_list = _sliced_insts_value_list->at( value_src );

    auto dst_it = dst_list->begin();
    auto src_it = src_list->begin();

    while ( dst_it != dst_list->end() || src_it != src_list->end() ) {
        if ( dst_it != dst_list->end() ) {
            tmp_list->push_back( *dst_it );
            dst_it ++;
        }
        else if ( src_it != src_list->end() ) {
            tmp_list->push_back( *src_it );
            src_it ++;
        }
        else {
            if ( util->inst2idx( *dst_it ) < util->inst2idx( *src_it ) ) {
                tmp_list->push_back( *dst_it );
                dst_it ++;
            }
            else {
                tmp_list->push_back( *src_it );
                src_it ++;
            }
        }
    }

    dst_list->clear();
    for ( auto inst : *tmp_list ) {
        dst_list->push_back( inst );
    }
}

bool SliceUtil::CreatePointerList( Value *value )
{
    if ( _pointer_list_table->find( value ) == _pointer_list_table->end() ) {
        return false;
    }

    _pointer_list_table->emplace( value, new vector<Value*> );
    return true;
}

void SliceUtil::AppendPointerList( Value *pointee, Value *pointer )
{
    assert( _pointer_list_table->find( pointee ) != _pointer_list_table->end() && "Pointee's list does not exist");

    _pointer_list_table->at( pointee )->push_back( pointer );
}

Value *SliceUtil::GetPointingValue( Value *value )
{
    for ( auto it : *_pointer_list_table ) {
        for ( auto pointer : *( it.second ) ) {
            if ( pointer == value ) {
                return it.first;
            }
        }
    }

    return nullptr;
    //assert( false && "Not found pointing value" );
}

bool SliceUtil::CreateAliasList( Value *value )
{
    if ( _alias_list->find( value ) == _alias_list->end() ) {
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

    Value *op = gepinst->getOperand( 0 );
    Value *head_value = GetAliasHeadValue( op );

    if ( is_alias ) {
        op = GetAliasHeadValue( op );
    }

    if ( head_value == nullptr ) {
        hash += to_string( (uint64_t)op );
    }
    else {
        hash += to_string( (uint64_t)head_value );
    }

    for ( int i = 1; i < gepinst->getNumOperands(); i ++ ) {
        Value *op = gepinst->getOperand( i );
        ConstantInt *constint = dyn_cast<ConstantInt>( op );
        hash += to_string( constint->getZExtValue() );
    }

    return hash;
}

bool SliceUtil::CreateElementList( string hash, GetElementPtrInst *gepinst )
{
    if ( _element_list->find( hash ) == _element_list->end() ) {
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

void SliceUtil::Slicing( Instruction *inst ) {
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
        string hash = MakeHash( gepinst, GetAliasHeadValue( object ) );

        if ( CreateElementList( hash, gepinst ) ) {
            CreateListForValue( inst );
            AppendInstForValue( inst, inst );
        } else {
            AppendElementList( hash, gepinst );
            GetElementPtrInst *head_value = GetHeadElement( hash );
            Value *pointee = GetPointingValue( head_value );
            if (  pointee != nullptr ) {
                AppendPointerList( pointee, inst );
            }
            AppendInstForValue( head_value, inst );
        }
        
        break;
    }
    case Instruction::Store :
    {
        Value *value = inst->getOperand( 0 );
        Value *var = inst->getOperand( 1 );
        GetElementPtrInst *varHeadElem;
        Value *varHeadAlias;

        if ( GetAliasHeadValue( value ) ) {
            assert( false && "Value has alias head value" );
        }

        varHeadAlias = GetAliasHeadValue( var );

        if ( var->getValueID() == Value::InstructionVal && 
            dyn_cast<Instruction>( var )->getOpcode() == Instruction::GetElementPtr ) {
                varHeadElem = GetHeadElement( MakeHash( varHeadElem, varHeadAlias ) );
        }

        if ( varHeadAlias != nullptr && varHeadElem != nullptr ) {
            assert( false && "var has both alias, elem" );
        }
        else if ( varHeadAlias != nullptr ) {
            if ( value->getType()->isPointerTy() ) {
                CreatePointerList( varHeadAlias );
                AppendPointerList( value, varHeadAlias );
            }
            if ( _sliced_insts_value_list->find( value ) != _sliced_insts_value_list->end() ) {
                Merge( varHeadAlias, value );
            }
            AppendInstForValue( varHeadAlias, inst );
        }
        else if ( varHeadElem != nullptr ) {
            if ( value->getType()->isPointerTy() ) {
                CreatePointerList( varHeadElem );
                AppendPointerList( value, varHeadElem );
            }
            if ( _sliced_insts_value_list->find( value ) != _sliced_insts_value_list->end() ) {
                Merge( varHeadElem, value );
            }
            AppendInstForValue( varHeadElem, inst );
        }
        else {
            if ( value->getType()->isPointerTy() ) {
                CreatePointerList( value );
                AppendPointerList( value, var );
            }
            if ( _sliced_insts_value_list->find( value ) != _sliced_insts_value_list->end() ) {
                Merge( var, value );
            }
            AppendInstForValue( var, inst );
        }

        break;
    }
    
    // Assume operand 0 is not temporary( unnamed variable )
    case Instruction::Load :
    {
        Value *var = inst->getOperand( 0 );
        Value *pointing_value;
        Value *varHeadAlias = GetAliasHeadValue( var );
        Value *varHeadElem;
        if ( var->getValueID() == Value::InstructionVal && 
            dyn_cast<Instruction>( var )->getOpcode() == Instruction::GetElementPtr ) {
                varHeadElem = GetHeadElement( MakeHash( varHeadElem, varHeadAlias ) );
        }

        if ( varHeadAlias != nullptr && varHeadElem != nullptr ) {
            assert( false && "var has both alias, elem" );
        }
        else if ( varHeadAlias != nullptr ) {
            pointing_value = GetPointingValue( varHeadAlias );
            if ( pointing_value != nullptr ) {
                AppendAliasList( pointing_value, inst );
            }
            AppendInstForValue( varHeadAlias, inst );
        }
        else if ( varHeadElem != nullptr ) {
            pointing_value = GetPointingValue( varHeadElem );
            if ( pointing_value != nullptr ) {
                AppendAliasList( pointing_value, inst );
            }
            AppendInstForValue( varHeadElem, inst );
        }
        else {
            pointing_value = GetPointingValue( var );
            if ( pointing_value != nullptr ) {
                AppendAliasList( pointing_value, inst );
            }
            AppendInstForValue( var, inst );
        }
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
        AppendInst( inst, inst, util );
        AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
        AppendInstsByOperand( inst, inst->getOperand( 1 ), util );
        break;
    }

    // Unary operator
    case Instruction::FNeg:
    {
        AppendInst( inst, inst, util );
        AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
        break;
    }
    
    case Instruction::Select :
    {
        AppendInst( inst, inst, util );
        AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
        AppendInstsByOperand( inst, inst->getOperand( 1 ), util );
        AppendInstsByOperand( inst, inst->getOperand( 2 ), util );
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
        // assert( false && "Call" );
        CallInst *callinst = dyn_cast<CallInst>( inst );
        Function *calledFunc = callinst->getCalledFunction();
        Value *operand = inst->getOperand( inst->getNumOperands() - 1 );
        
        if ( operand->getValueID() != Value::FunctionVal ) {
            Value *v = FindAlias( operand );
            if ( v == nullptr ) {
                calledFunc = nullptr;
            }
            else {
                calledFunc = dyn_cast<Function>( v );
            }
        }
        else {
            calledFunc = callinst->getCalledFunction();
        }

        if ( calledFunc != nullptr ) {
            assert ( calledFunc->getValueID() == Value::FunctionVal && "Not a Function value" );
            AppendInst( inst, inst, util );
            for ( int i = 0; i < inst->getNumOperands() - 1; i ++ ) {
                AppendInstsByOperand( inst, inst->getOperand( i ), util );
            }
        }
        else {
            AppendInst( inst, inst, util );
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
        
        
        break;
    }
    case Instruction::ShuffleVector :
    {
        //assert( false && "ShuffleVector" );
        AppendInst( inst, inst, util );
        AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
        AppendInstsByOperand( inst, inst->getOperand( 1 ), util );
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
        //assert( false && "InsertElement" );
        Value *vec = inst->getOperand( 0 );
        Value *elem = inst->getOperand( 1 );

        // Due to poison
        AppendInst( inst, inst, util );
        AppendInst( vec, inst, util );
        AppendInstsByOperand( vec, elem, util );
        AppendInstsByOperand( inst, vec, util );
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
        //assert( false && "ExtractElement" );
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
        AppendInstsByOperand( inst, inst->getOperand( 0 ), util );
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