#include "slice_test.h"
#include "UtilDef.h"

#include <llvm/IR/Instructions.h>

#include <cassert>

void SliceUtil::PrintSliceResult( Value *value ) const
{
    UtilDef *util = new UtilDef;
    for ( auto it : *_sliced_insts_value_list->at( value ) ) {
        outs() << util->inst2str( it ) << "\n";
    }
}

void SliceUtil::PrintSliceResult( int idx ) const
{
    PrintSliceResult( (*_values)[idx] );
}

void SliceUtil::PrintValueList( void ) const
{
    UtilDef *util = new UtilDef;
    int i = 0;
    for ( auto value : *_values ) {
        outs() << i << " : ";
        if ( value->getName().empty() ) {
            outs() << util->inst2str( value );
        }
        else {
            outs() << value->getName();
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
    UtilDef *util = new UtilDef;
    if ( _sliced_insts_value_list->find( value_dst ) == _sliced_insts_value_list->end() ) {
        outs() << "assert : " << util->inst2str( value_dst ) << "\n";
        assert( _sliced_insts_value_list->find( value_dst ) != _sliced_insts_value_list->end() && "Value's list does not exist");
    }
    

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

    while ( dst_it != dst_list->end() && src_it != src_list->end() ) {
        if ( util->inst2idx( *dst_it ) == util->inst2idx( *src_it ) ) {
            tmp_list->push_back( *dst_it );
            dst_it ++;
            src_it ++;
        }
        else if ( util->inst2idx( *dst_it ) < util->inst2idx( *src_it ) ) {
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

bool SliceUtil::CreatePointerList( Value *value )
{
    if ( _pointer_list_table->find( value ) != _pointer_list_table->end() ) {
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

    for ( uint32_t i = 1; i < gepinst->getNumOperands(); i ++ ) {
        Value *op = gepinst->getOperand( i );
        ConstantInt *constint = dyn_cast<ConstantInt>( op );
        hash += to_string( constint->getZExtValue() );
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

void SliceUtil::Slicing( Instruction *inst ) {
    UtilDef *util = new UtilDef;
    outs() << SVF::SVFUtil::pasMsg( util->inst2str( inst ) ) << "\n";
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
        Value *aliasHeadValue = nullptr;
        GetElementPtrInst *varHeadElem = nullptr;
        string hash;

        aliasHeadValue = GetAliasHeadValue( object );

        if ( aliasHeadValue == nullptr )
            hash = MakeHash( gepinst, false );
        else
            hash = MakeHash( gepinst, true );

        varHeadElem = GetHeadElement( hash );

        if ( aliasHeadValue != nullptr && varHeadElem != nullptr ) {
            //assert( false && "object has both alias, elem" );
            hash = MakeHash( varHeadElem, false );
            AppendElementList( hash, gepinst );
            GetElementPtrInst *head_value = GetHeadElement( hash );
            Value *pointee = GetPointingValue( head_value );
            if (  pointee != nullptr ) {
                AppendPointerList( pointee, inst );
            }                
            AppendInstForValue( head_value, inst );
            Merge( head_value, aliasHeadValue );
            Merge( head_value, varHeadElem );
        }
        else if ( aliasHeadValue != nullptr ) {
            if ( CreateElementList( hash, gepinst ) ) {
                CreateListForValue( gepinst );
                AppendInstForValue( inst, inst );
                Merge( inst, aliasHeadValue );
            }
            else {
                AppendElementList( hash, gepinst );
                GetElementPtrInst *head_value = GetHeadElement( hash );
                Value *pointee = GetPointingValue( head_value );
                if (  pointee != nullptr ) {
                    AppendPointerList( pointee, inst );
                }                
                AppendInstForValue( head_value, inst );
                Merge( head_value, aliasHeadValue );
            }
            
        }
        else if ( varHeadElem != nullptr ) {
            AppendElementList( hash, gepinst );
            GetElementPtrInst *head_value = GetHeadElement( hash );
            Value *pointee = GetPointingValue( head_value );
            if (  pointee != nullptr ) {
                AppendPointerList( pointee, inst );
            }                
            AppendInstForValue( head_value, inst );
            Merge( head_value, object );
        }
        else {
            if ( CreateElementList( hash, gepinst ) ) {
                CreateListForValue( gepinst );
                AppendInstForValue( inst, inst );
                Merge( inst, object );
            }
            else {
                AppendElementList( hash, gepinst );
                GetElementPtrInst *head_value = GetHeadElement( hash );
                Value *pointee = GetPointingValue( head_value );
                if (  pointee != nullptr ) {
                    AppendPointerList( pointee, inst );
                }                
                AppendInstForValue( head_value, inst );
                Merge( head_value, object );
            }
        }
        
        break;
    }
    case Instruction::Store :
    {
        Value *value = inst->getOperand( 0 );
        Value *var = inst->getOperand( 1 );
        GetElementPtrInst *varHeadElem = nullptr;
        Value *varHeadAlias = nullptr;

        if ( GetAliasHeadValue( value ) ) {
            assert( false && "Value has alias head value" );
        }

        varHeadAlias = GetAliasHeadValue( var );

        if ( var->getValueID() == Value::InstructionVal + Instruction::GetElementPtr ) {
            bool is_alias = true;
            if ( varHeadAlias == nullptr )
                is_alias = false;
            string hash = MakeHash( dyn_cast<GetElementPtrInst>( var ), is_alias );
            varHeadElem = GetHeadElement( hash );
        }

        if ( varHeadAlias != nullptr && varHeadElem != nullptr ) {
            assert( false && "var has both alias, elem" );
        }
        else if ( varHeadAlias != nullptr ) {
            if ( value->getType()->isPointerTy() ) {
                CreatePointerList( value );
                AppendPointerList( value, varHeadAlias );
            }
            if ( _sliced_insts_value_list->find( value ) != _sliced_insts_value_list->end() ) {
                Merge( varHeadAlias, value );
            }
            AppendInstForValue( varHeadAlias, inst );
        }
        else if ( varHeadElem != nullptr ) {
            if ( value->getType()->isPointerTy() ) {
                CreatePointerList( value );
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
        Value *pointing_value = nullptr;
        Value *varHeadAlias = GetAliasHeadValue( var );
        Value *varHeadElem = nullptr;
        if ( var->getValueID() == Value::InstructionVal + Instruction::GetElementPtr) {
                varHeadElem = GetHeadElement( MakeHash( dyn_cast<GetElementPtrInst>( var ), varHeadAlias ) );
        }

        if ( varHeadAlias != nullptr && varHeadElem != nullptr ) {
            assert( false && "var has both alias, elem" );
        }
        else if ( varHeadAlias != nullptr ) {
            pointing_value = GetPointingValue( varHeadAlias );
            if ( pointing_value != nullptr ) {
                CreateAliasList( pointing_value );
                AppendAliasList( pointing_value, inst );
            }
            //AppendInstForValue( varHeadAlias, inst );
        }
        else if ( varHeadElem != nullptr ) {
            pointing_value = GetPointingValue( varHeadElem );
            if ( pointing_value != nullptr ) {
                CreateAliasList( pointing_value );
                AppendAliasList( pointing_value, inst );
            }
            //AppendInstForValue( varHeadElem, inst );
        }
        else {
            pointing_value = GetPointingValue( var );
            if ( pointing_value != nullptr ) {
                CreateAliasList( pointing_value );
                AppendAliasList( pointing_value, inst );
            }
            //AppendInstForValue( var, inst );
        }
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );
        Merge( inst, GetHeadValue ( inst->getOperand( 0 ) ) );
        Merge( GetHeadValue ( inst->getOperand( 0 ) ), inst );
        break;
    }
    
    // term ops
    case Instruction::Br :
    case Instruction::Switch :
    {
        
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
        
        break;
    }

    // Unary operator
    case Instruction::FNeg:
    {
        
        break;
    }
    
    case Instruction::Select :
    {
        
        break;
    }
    
    case Instruction::AtomicCmpXchg :
    {
        assert( false && "AtomicCmpXchg" );
        break;
    }
    case Instruction::AtomicRMW :
    {
        assert( false && "AtomicRMW" );

        break;
    }
    case Instruction::Call :
    {
        // assert( false && "Call" );
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );
        break;
    }
    case Instruction::ShuffleVector :
    {
        //assert( false && "ShuffleVector" );
        break;
    }
    case Instruction::Ret :
    {  
        //assert( false && "Ret" );
        break;
    }
    case Instruction::PHI :
    {
        //assert( false && "PHI" );
        break;
    }
    case Instruction::InsertElement :
    {
        //assert( false && "InsertElement" );
        break;
    }
    case Instruction::InsertValue :
    {
        
        //assert( false && "InsertValue" );
        
        break;
    }
    case Instruction::Fence :
    {
        assert( false && "Fence" );
        break;
    }
    case Instruction::ExtractElement :
    {
        //assert( false && "ExtractElement" );
        break;
    }
    case Instruction::ExtractValue :
    {
        //assert( false && "ExtractValue" );
        break;
    }
    case Instruction::LandingPad :
    {
        //assert( false && "LandingPad" );
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
        CreateListForValue( inst );
        AppendInstForValue( inst, inst );
        Merge( inst, inst->getOperand( 0 ) );
        break;
    }

    // Just Pass
    case Instruction::Unreachable :
    {
        break;
    }

    default:
        //outs() << "assert : " << inst->getOpcodeName() << "\n";
        //outs() << "assert : " << util->inst2str( inst ) << "\n";
        assert( false && "Not handled instruction" );
        break;
    }
    ForDebugPrint();
}

void SliceUtil::ForDebugPrint( void )
{
    UtilDef *util = new UtilDef;
    outs() << "|\t\t|\n";
    for ( auto it : *_sliced_insts_value_list ) {
        outs() << (it.first)->getName() << "\n";
        for ( auto i : *it.second ) {
            outs() << util->inst2str( i ) << "\n";
        }
    }
}