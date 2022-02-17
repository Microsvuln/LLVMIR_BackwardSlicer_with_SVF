# SVF_Practice

This is SVF & llvm practice repo. These codes use SVF library. Please refer to below repo.

Link: [SVF](https://github.com/SVF-tools/SVF, "SVF tools")


# Usage
## Trace All Components
Before build code, you must run "setup.sh" in SVF.
```
cd TraceAllComponents
cmake .
make
./bin/traceAllComponents ../testfiles/test.ll ( or your own test.ll or .bc )
```