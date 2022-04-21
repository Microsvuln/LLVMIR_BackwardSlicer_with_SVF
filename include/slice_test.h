#ifndef SLICE_TEST_H_
#define SLICE_TEST_H_

#include "UtilDef.h"

#include <llvm/IR/Value.h>
#include <llvm/IR/Instruction.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Function.h>

#include <map>
#include <vector>
#include <string>
#include <set>

using namespace std;
using namespace llvm;

class SliceUtil {
private:
    map <Value*, vector<Instruction*>*>*        _inter_sliced_list;
    map <Value*, vector<Instruction*>*>*        _sliced_insts_value_list;
    map <BasicBlock*, vector<Instruction*>*>*   _sliced_insts_block_list;
    map <Value*, Value*>*                       _pointer_list_table;
    map <Value*, vector<Value*>*>*              _alias_list;
    map <string, vector<GetElementPtrInst*>*>*  _element_list;
    map <string, GetElementPtrInst*>*           _head_element_list;
    vector <Value*>*                            _values;
    Value*                                      _return_value;
    UtilDef*                                    _util;
    set<string>*                                _ignore_func_list;
public:
    SliceUtil( void )
        : _inter_sliced_list        ( new map <Value*, vector<Instruction*>*> )
        , _sliced_insts_value_list  ( new map <Value*, vector<Instruction*>*> )
        , _sliced_insts_block_list  ( new map <BasicBlock*, vector<Instruction*>*> )
        , _pointer_list_table       ( new map <Value*, Value*> )
        , _alias_list               ( new map <Value*, vector<Value*>*> )
        , _element_list             ( new map <string, vector<GetElementPtrInst*>*> )
        , _head_element_list        ( new map <string, GetElementPtrInst*> )
        , _values                   ( new vector<Value*> )
        , _return_value             ( nullptr )
        , _util                     ( new UtilDef )
        ,_ignore_func_list          ( new set<string> )
    {
        //px4 constructor
        // @_ZN4uORB12DeviceMasterC1Ev = hidden unnamed_addr alias void (%"class.uORB::DeviceMaster"*), void (%"class.uORB::DeviceMaster"*)* @_ZN4uORB12DeviceMasterC2Ev
        _ignore_func_list->insert( "_ZN4uORB12DeviceMasterC1Ev" );
        _ignore_func_list->insert( "_ZN4uORB10DeviceNodeC1EPK12orb_metadatahPKch" );
    }

    vector<Instruction*>*                   GetInstListByValue      ( Value *value );
    vector<Instruction*>*                   GetInterInstListByValue ( Value *value );
    map <Value*, vector<Instruction*>*>*    GetSlicedList           ( void );
    map <Value*, vector<Instruction*>*>*    GetInterSlicedList      ( void );
    Value*                                  GetReturnValue          ( void );
    Value*                                  GetValueByIndex         ( int idx );

    bool    IsIgnoreFunc                ( Instruction *inst );

    void    AppendBranchConditionInst   ( void );

    void    PrintSliceResult            ( Value *value ) const;
    void    PrintSliceResult            ( int idx ) const;
    void    PrintValueList              ( void ) const;

    // If list is existed, returns false or successfully create list, returns true.
    bool    CreateListForValue          ( Value *value );
    bool    CreateListForBlock          ( BasicBlock *bb );

    // List must be existed. If not, assert occur.
    void    AppendInstForValue          ( Value *value_dst, Instruction *inst );
    void    AppendInstForBlock          ( BasicBlock *bb_dst, Instruction *inst );

    // Merge instruction list from value to another value.
    void    Merge                       ( Value *value_dst, Value *value_src );
    void    MergeForBranch              ( Value *value_dst, BasicBlock *bb_src );
    
    // For handling pointer 
    void    AppendPointerList           ( Value *pointee, Value *pointer );
    Value*  GetPointingValue            ( Value *value );
    Value*  GetPointerValue             ( Value *value );
    bool    CreateAliasList             ( Value *value );
    void    AppendAliasList             ( Value *head_value, Value *value );
    Value*  GetAliasHeadValue           ( Value *value );

    Value*  GetHeadValue                ( Value* value );
    void    Slicing                     ( Instruction *inst );
    void    ForDebugPrint               ( void );

    // For handling class element
    bool                CreateElementList   ( string hash, GetElementPtrInst *gepinst );
    void                AppendElementList   ( string hash, GetElementPtrInst *gepinst );
    string              MakeHash            ( Instruction *inst, bool is_alias );
    GetElementPtrInst*  GetHeadElement      ( string hash );

    
};

#endif