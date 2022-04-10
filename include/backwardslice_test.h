#ifndef BACKWARDSLICE_TEST_H_
#define BACKWARDSLICE_TEST_H_

class BackwardSlice {
private:

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