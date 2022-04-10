#ifndef SLICE_TEST_H_
#define SLICE_TEST_H_

class SliceUtil {
private:

public:

    // If list is existed, returns false or successfully create list, returns true.
    bool CreateList( Value *value );
    bool CreateList( BasicBlock *bb );

    // List must be existed. If not, assert occur.
    bool AppendInst( Value *value, Instruction *inst );
    bool AppendInst( BasicBlock *bb, Instruction *inst );

    // Merge instruction list from value to another value.
    void Merge( Value *value, Value *value );
};

#endif