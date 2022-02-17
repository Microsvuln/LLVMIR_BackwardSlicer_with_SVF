# SVF_Practice

For SVF & llvm practice
These codes use SVF library.
Please refer to below repo.
[SVF][svfrepolink]
[svfrepolink]: https://github.com/SVF-tools/SVF


# Usage
## Trace All Components
Before build code, you must run "setup.sh" in SVF.
'''
cd TraceAllComponents
cmake .
make
./bin/traceAllComponents ../testfiles/test.ll ( or your own test.ll or .bc )
'''