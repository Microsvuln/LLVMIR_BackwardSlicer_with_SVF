#include "backwardslice.h"
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

    Backward *bw = new Backward;

    vector<Function*> functions;
    vector<bool> isSliced;

    //PrintAllComponent( svfModule );

    int i = 0;
    for ( auto func : *svfModule ) {
        //outs() << pasMsg("Function : " + func->getName() + "\n" );
        Function *llvmFunc = func->getLLVMFun();
        functions.push_back( llvmFunc );
        outs() << to_string( i ++ ) << " : " << llvmFunc->getName() << "\n";
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
        case -2:
        {
            outs() << "idx : ";
            cin >> idx;
            for ( int i = idx; i < functions.size(); i ++ ) {
                bw->SliceFunction( functions[i] );
            }
            break;
        }
        case -3:
        {
            outs() << "idx : ";
            cin >> idx;
            PrintByFunction( functions[idx] );
            break;
        }
        default:
        {
            Function *func = functions[idx];
            //PrintByFunction( functions[idx] );
            if ( !isSliced[idx] ) {
                bw->SliceFunction( func );
                isSliced[idx] = true;
            }
            bw->PrintValueList( func );
            cin >> idx;
            bw->PrintByValueIdx( func, idx );
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