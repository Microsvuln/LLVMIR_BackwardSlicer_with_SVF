#ifndef BACKWARDSLICE_TEST_H_
#define BACKWARDSLICE_TEST_H_

#include "slice_test.h"

// #include "UtilDef.h"

#include <llvm/IR/Value.h>
#include <llvm/IR/Function.h>

#include <map>

using namespace std;
using namespace llvm;

class BackwardSlice {
private:
    map <Function*, SliceUtil*> *_sliced_func_list;
public:
    // Intra-level backward slice
    void IntraSlicing( Function *func );

    // Intra-level slicing must be done before calling below functions
    void AppendBranchConditionInst( Function *func );
    void InterSlicing( Function *func );

    // print result of backward slice
    void Print( Function *func, Value *value ); 

    // print sliced variable list
    void PrintValueList( Function *func );
};

#endif