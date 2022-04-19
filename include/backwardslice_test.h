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
        // px4 uorb
        // parameter값을 class 로 typecasting 해서 함수포인터 맴버변수로 함수호출함. 여기서 막혀서 제외시킴.
        _ignore_func_list_for_interslice->insert( "_ZN4uORB10DeviceNode7publishEPK12orb_metadataPvPKv" );
        _ignore_func_list_for_interslice->insert( "_ZN4uORB12DeviceMaster9advertiseEPK12orb_metadatabPi" );
        

        // px4 constructor
        // @_ZN4uORB12DeviceMasterC1Ev = hidden unnamed_addr alias void (%"class.uORB::DeviceMaster"*), void (%"class.uORB::DeviceMaster"*)* @_ZN4uORB12DeviceMasterC2Ev
        _ignore_func_list_for_interslice->insert( "_ZN4uORB12DeviceMasterC1Ev" );
        _ignore_func_list_for_interslice->insert( "_ZN4uORB10DeviceNodeC1EPK12orb_metadatahPKch" );
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