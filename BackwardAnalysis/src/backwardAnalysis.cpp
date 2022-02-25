#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"
#include "llvm/IR/ModuleSlotTracker.h"
#include "util/UtilDef.h"

#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;
using SVF::SVFUtil::pasMsg;

class Backward {
public:
    Backward()
        : mBwInstLists( new unordered_map<Value*, vector<Value*>*> )
        , mBwValueToFindLists( new unordered_map<Value*, vector<Value*>*> )
    {}

    unordered_map<Value*, vector<Value*>*> *getInstLists( void ) const
    {
        return mBwInstLists;
    }

    unordered_map<Value*, vector<Value*>*> *getValueToFindLists( void ) const
    {
        return mBwValueToFindLists;
    }

    void AppendInstsByOperand( Value *result, Value *operand )
    {
        if ( mBwInstLists->find( result ) == mBwInstLists->end() ) {
            mBwInstLists->emplace( result, new vector<Value*> );
        }
        if ( mBwInstLists->find( operand ) == mBwInstLists->end() ) {
            return;
        }

        for ( auto it : *mBwInstLists->at( operand ) ) {
            mBwInstLists->at( result )->push_back( it );
        }
    }

    void AppendInstsByOperand2( Value *result, Value *operand1, Value *operand2, UtilDef *util )
    {
        if ( mBwInstLists->find( result ) == mBwInstLists->end() ) {
            mBwInstLists->emplace( result, new vector<Value*> );
        }


        if ( mBwInstLists->find( operand1 ) == mBwInstLists->end() && 
            mBwInstLists->find( operand2 ) == mBwInstLists->end() ) 
        {
        }
        else if ( mBwInstLists->find( operand1 ) != mBwInstLists->end() ) {
            AppendInstsByOperand( result, operand1 );
        }
        else if ( mBwInstLists->find( operand2 ) != mBwInstLists->end() ) {
            AppendInstsByOperand( result, operand2 );
        }
        else {
            auto it1 = mBwInstLists->at( operand1 )->begin();
            auto it2 = mBwInstLists->at( operand2 )->begin();

            while ( it1 != mBwInstLists->at( operand1 )->end() ||
                    it2 != mBwInstLists->at( operand2 )->end() )
            {
                if ( util->inst2idx( *it1 ) < util->inst2idx( *it2 ) ) {
                    mBwInstLists->at( result )->push_back( *it1 );
                    it1 ++;
                }
                else {
                    mBwInstLists->at( result )->push_back( *it2 );
                    it2 ++;
                }
            }
        }  
    }

    void AppendInst( Value *key, Value *v )
    {
        Instruction *newInst = dyn_cast<Instruction>( v );

        if ( mBwInstLists->find( key ) == mBwInstLists->end() ) {
            mBwInstLists->emplace( key, new vector<Value*> );
            mBwInstLists->at( key )->push_back( newInst->getParent() );
            mBwInstLists->at( key )->push_back( v );
            return;
        }

        Instruction *lastInst = dyn_cast<Instruction>( mBwInstLists->at( key )->back() );
        if ( lastInst->getParent() != newInst->getParent() ) {
            mBwInstLists->at( key )->push_back( newInst->getParent() );
        }

        mBwInstLists->at( key )->push_back( v );
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
        if ( mBwValueToFindLists->find( key ) == mBwValueToFindLists->end() ) {
            return false;
        }
        for ( auto valueToFind : *mBwValueToFindLists->at( key ) ) {
            if ( valueToFind == v ) {
                return true;
            }
        }
        return false;
    }

    vector<Value*> *GetKeysFromFindValue( Value *v ) const 
    {
        vector<Value*> *keys = new vector<Value*>;
        for ( auto it : *mBwValueToFindLists ) {
            for ( auto val : *( it.second ) ) {
                if ( val == v ) {
                    keys->push_back( it.first );
                    break;
                }
            }
        }

        return keys;
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
            
            for ( auto value : *( it.second ) ) {
                
                if ( value->getValueID() == 20 ) {
                    outs() << value->getName().str() << "\n";
                }
                else {
                    Instruction *inst = dyn_cast<Instruction>( value );
                    
                    outs() //<< 
                    
                           << util->inst2str( value ) << "\n";
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
private:
    unordered_map<Value*, vector<Value*>*> *mBwInstLists;
    unordered_map<Value*, vector<Value*>*> *mBwValueToFindLists;
};

// For getting llvm IR file as argv 
static llvm::cl::opt<std::string> InputFilename( llvm::cl::Positional,
        llvm::cl::desc( "<input bitcode>" ), llvm::cl::init( "-" ) );

int main( int argc, char *argv[] )
{
    UtilDef *util = new UtilDef;
    int arg_num = 0;
    char **arg_value = new char*[argc];

    // Init arguments
    std::vector<std::string> moduleNameVec;
    SVF::SVFUtil::processArguments( argc, argv, arg_num, arg_value, moduleNameVec );
    llvm::cl::ParseCommandLineOptions( arg_num, arg_value, "bwInstLists all components\n" );

    // Init svf module
    SVF::SVFModule *svfModule = SVF::LLVMModuleSet::getLLVMModuleSet()->buildSVFModule( moduleNameVec );
    svfModule->buildSymbolTableInfo();

    Backward *bw = new Backward;

    for ( auto func : *svfModule ) {
        Function *llvmFunc = func->getLLVMFun();
        Module *llvmModule = llvmFunc->getParent();
        ModuleSlotTracker *llvmMST = new ModuleSlotTracker( llvmModule );

        util->instIdxer( llvmFunc );
        
        for ( auto &basicBlock : *llvmFunc ) {
            outs() << pasMsg( "[DEBUG] BasicBlock : " ) << pasMsg( basicBlock.getName().str() ) << "\n";
            for ( auto &inst : basicBlock ) {
                outs() << pasMsg( "[DEBUG] <" ) << util->inst2idx( &inst ) << pasMsg( util->inst2str( &inst ) ) << pasMsg( " >" )
                       << pasMsg( " : " ) << &inst << "\n";
                outs() << pasMsg( "[DEBUG] TYPE : " ) << pasMsg( util->getOperatorTypeName( &inst ) ) << "\n";
                unsigned int opcode = inst.getOpcode();
                vector<Value*> operands;
                for ( int i = 0; i < inst.getNumOperands(); i ++ ) {
                    llvm::Value *operand = inst.getOperand( i );
                    std::string operandName = operand->getName().str();
                    operands.push_back( operand );
                    outs() << pasMsg( "[DEBUG] PUSH OPR : " ) << pasMsg( operandName ) << "\t\t";

                    unsigned int valueID = operand->getValueID();
                    if ( valueID == llvm::Value::ConstantIntVal ) {
                        llvm::ConstantInt *constint = dyn_cast<ConstantInt>( operand );
                        outs() << pasMsg( "Int Val! : " ) << pasMsg( std::to_string( constint->getSExtValue() ) );
                    }
                    else {
                        outs() << pasMsg( "ValueID : " ) << pasMsg( std::to_string( operand->getValueID() ) );
                               //<< pasMsg( "  OptData : " ) << pasMsg( std::to_string( subOptData ) )
                               
                    }
                    outs() << " : " << operand << "\n";
                }

                switch ( opcode ) {

                case Instruction::Alloca :
                case Instruction::GetElementPtr :
                {
                    bw->AppendInst( &inst, &inst );
                    bw->AppendFindValue( &inst, &inst );
                    break;
                }
                case Instruction::Store :
                {
                    Value *value = inst.getOperand( 0 );
                    Value *var = inst.getOperand( 1 );
                    
                    bw->AppendInstsByOperand( var, value );
                    bw->AppendInst( var, &inst );
                    break;
                }
                // Assume operand 0 is not temporary( unnamed variable )
                case Instruction::Load :
                {
                    Value *var = inst.getOperand( 0 );

                    bw->AppendInstsByOperand( &inst, var );
                    bw->AppendInst( &inst, &inst );
                    break;
                }

                // term ops
                case Instruction::Br :
                case Instruction::Switch :
                // other ops
                case Instruction::ICmp :
                case Instruction::FCmp :
                    for ( auto o : operands ) {
                        if ( bw->isKey( o ) ) {
                            bw->AppendInstsByOperand( &inst, o );
                        }
                    }
                    bw->AppendInst( &inst, &inst );
                    break;
                /*
                    condition에 따라 다른 값에 영향을 미치는 경우도 포함시켜야 하는지 고민 중
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
                    Value *op1 = inst.getOperand( 0 );
                    Value *op2 = inst.getOperand( 1 );
                    bw->AppendInstsByOperand2( &inst, op1, op2, util );
                    bw->AppendInst( &inst, &inst );
                    break;
                }
                default:
                    break;
                }
            }
        }
    }

    bw->PrintAll();

    delete util;
    
    return 0;
}