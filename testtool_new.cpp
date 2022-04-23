#include "backwardslice_test.h"
#include "traceallcomponents.h"

// For getting llvm IR file as argv 
static llvm::cl::opt<std::string> InputFilename( llvm::cl::Positional,
        llvm::cl::desc( "<input bitcode>" ), llvm::cl::init( "-" ) );

int main( int argc, char *argv[] )
{
    int arg_num = 0;
    char **arg_value = new char*[argc];

    // Init arguments
    std::vector<std::string> moduleNameVec;
    SVF::SVFUtil::processArguments( argc, argv, arg_num, arg_value, moduleNameVec );
    llvm::cl::ParseCommandLineOptions( arg_num, arg_value, "bwInstLists all components\n" );

    // Init svf module
    SVF::SVFModule *svfModule = SVF::LLVMModuleSet::getLLVMModuleSet()->buildSVFModule( moduleNameVec );
    svfModule->buildSymbolTableInfo();

    UtilDef *util = new UtilDef;
    BackwardSlice *bw = new BackwardSlice;

    vector<Function*> functions;
    vector<bool> isSliced;

    //PrintAllComponent( svfModule );

    int i = 0;
    for ( auto func : *svfModule ) {
        //outs() << pasMsg("Function : " + func->getName() + "\n" );
        Function *llvmFunc = func->getLLVMFun();
        functions.push_back( llvmFunc );
        /*
        outs() << to_string( i ) << " : " << func->getName() << "\n";
        const char *demangled = util->Demangle( llvmFunc->getName().str().c_str() );
        if ( demangled != nullptr ) {
            outs() << demangled << "\n";
        }
        else { 
            outs() << "NULL" << "\n";
        }
        */
        i ++;
    }
    isSliced.resize( functions.size() );
    std::fill( isSliced.begin(), isSliced.end(), false );

    while( true ) {
        int idx;
        bool done = false;
        outs() << "select : ";
        cin >> idx;
        switch( idx ) {
            case -1:
            {
                done = true;
                break;
            }
            // print instruction informations
            case -2:
            {
                outs() << "function idx : ";
                cin >> idx;
                Function *func = functions[idx];
                PrintByFunction( func );
                break;
            }
            // Intra-level slice test for all function 
            case -3:
            {
                for ( auto func : *svfModule ) {
                    outs() << "Function : " + func->getName() + "\n";
                    Function *llvmFunc = func->getLLVMFun();
                    bw->IntraSlicing( llvmFunc );
                    i ++;
                }
                outs() << "done\n";
                break;
            }
            default:
            {
                Function *func = functions[idx];
                //PrintByFunction( functions[idx] );
                if ( !isSliced[idx] ) {
                    bw->BackwardSlicingMain( func, new map<Function*, int> );
                    isSliced[idx] = true;
                }
                bw->PrintByValueIdx( func );
                //bw->PrintByFunction( functions[idx] );
                break;
            }
        }
        if ( done ) {
            break;
        }
    }

/*
    for ( auto func : *svfModule ) {
        Function *llvmFunc = func->getLLVMFun();
        bw->PrintByFunction( llvmFunc );
    }
*/
    
    delete bw;
    
    return 0;
}