# SVF_Practice

This is SVF & llvm practice repo. These codes use SVF library. Please refer to below repo.

Link: [SVF](https://github.com/SVF-tools/SVF)


# Usage
Before build code, you must run "setup.sh" in SVF.
```
cd SVF_Practice
mkdir build && cd build
cmake ..
make
./bin/TestTool ../testfiles/ir/test.ll ( or your own test.ll or .bc )
```

# Result
Print result of backward slicing each variable.

