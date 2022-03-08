#ifndef TRACEALLCOMPONENET_H_
#define TRACEALLCOMPONENET_H_

#include "Util/SVFUtil.h"
#include "SVF-FE/LLVMUtil.h"

void PrintAllComponent  ( SVF::SVFModule *svfModule );
void PrintByFunction    ( llvm::Function *func );

#endif