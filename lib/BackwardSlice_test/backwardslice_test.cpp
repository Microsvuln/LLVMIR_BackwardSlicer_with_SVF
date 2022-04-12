#include "backwardslice_test.h"
#include "slice_test.h"

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