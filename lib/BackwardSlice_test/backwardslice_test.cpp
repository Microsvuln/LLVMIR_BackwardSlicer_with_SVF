#include "backwardslice_test.h"
#include "slice_test.h"

#include <iostream>

void BackwardSlice::IntraSlicing( Function *func )
{
    if ( _sliced_func_list->find( func ) != _sliced_func_list->end() ) {
        return ;
    }

    SliceUtil *newSliceUtil = new SliceUtil;

    for ( auto &bb : *func ) {
        for ( auto &inst : bb ) {
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