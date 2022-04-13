#include "UtilDef.h"
#include "backwardslice_test.h"
#include "slice_test.h"

#include <iostream>

void BackwardSlice::IntraSlicing( Function *func )
{
    UtilDef *util = new UtilDef;
    if ( _sliced_func_list->find( func ) != _sliced_func_list->end() ) {
        return ;
    }

    SliceUtil *newSliceUtil = new SliceUtil;

    for ( auto it = func->arg_begin(); it != func->arg_end(); it ++ ) {
        newSliceUtil->CreateListForValue( &(*it) );
    }

    for ( auto &bb : *func ) {
        for ( auto &inst : bb ) {
            if ( util->inst2str( &inst ).find( "llvm.dbg." ) != string::npos )
                    continue;
            newSliceUtil->Slicing( &inst );
        }
    }

    _sliced_func_list->emplace( func, newSliceUtil );
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