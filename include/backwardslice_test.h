#ifndef BACKWARDSLICE_TEST_H_
#define BACKWARDSLICE_TEST_H_

#include "slice_test.h"

// #include "UtilDef.h"

#include <llvm/IR/Value.h>
#include <llvm/IR/Function.h>

#include <map>
#include <set>

using namespace std;
using namespace llvm;

class BackwardSlice {
private:
    map <Function*, SliceUtil*>*    _sliced_func_list;
    set<string>*                 _ignore_func_list_for_interslice;
public:
    BackwardSlice( void )
        : _sliced_func_list( new map <Function*, SliceUtil*> )
        , _ignore_func_list_for_interslice( new set<string> )
    {
        // standard
        _ignore_func_list_for_interslice->insert( "_Znam" );
        _ignore_func_list_for_interslice->insert( "_Znwm" );
        _ignore_func_list_for_interslice->insert( "strcmp" );
        //_ignore_func_list_for_interslice->insert( "_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6assignEPKc" );

        // llvm function
        _ignore_func_list_for_interslice->insert( "llvm.lifetime.end.p0i8" );
        
        // px4 general functions
        //_ignore_func_list_for_interslice->insert( "hrt_absolute_time" );
        //_ignore_func_list_for_interslice->insert( "px4_sem_init" );
        //_ignore_func_list_for_interslice->insert( "px4_sem_wait" );
        //_ignore_func_list_for_interslice->insert( "px4_sem_post" );

        // px4 uorb
        _ignore_func_list_for_interslice->insert( "_ZN4uORB10DeviceNode7publishEPK12orb_metadataPvPKv" );
        // parameter값을 class 로 typecasting 해서 함수포인터 맴버변수로 함수호출함. 여기서 막혀서 제외시킴.


        // iterator
        //_ignore_func_list_for_interslice->insert( "_ZN19IntrusiveSortedListIPN4uORB10DeviceNodeEE8IteratorppEv" );
        //_ignore_func_list_for_interslice->insert( "_ZN19IntrusiveSortedListIPN4uORB10DeviceNodeEE8IteratorC2ES2_" );
        //_ignore_func_list_for_interslice->insert( "_ZN19IntrusiveSortedListIPN4uORB10DeviceNodeEE8IteratorC1ES2_" );
        //_ignore_func_list_for_interslice->insert( "_ZN19IntrusiveSortedListIPN4uORB10DeviceNodeEE3endEv" );
        //_ignore_func_list_for_interslice->insert( "_ZN19IntrusiveSortedListIPN4uORB10DeviceNodeEE8IteratorppEv" );

    }

    void BackwardSlicing            ( Function *func );

    // Intra-level backward slice
    void IntraSlicing               ( Function *func );

    // Intra-level slicing must be done before calling below functions
    void AppendBranchConditionInst  ( Function *func );
    void InterSlicing               ( Function *func );

    // print result of backward slice
    void Print                      ( Function *func, Value *value ); 

    // print sliced variable list
    void PrintByValueIdx            ( Function *func );
};

#endif