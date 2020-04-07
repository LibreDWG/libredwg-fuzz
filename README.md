My afl++ fuzzer setup
---------------------

Use two build directories: `.build-asan` and `.build-fuzz-asan`.

* `.build-fuzz-asan` contains the fuzzer config, fuzzer input and outpur dirs
* `.build-asan` contains the normal asan config, and scripts to verify and
   debug the crashes collected in `.build-fuzz-asan`.

failures are automatically seperated into crashes, hangs and leaks,
see `fuzzlib.sh`

fuzzer targets are injson, indxf, rw, outdxf, outjson, svg, bmp.

fuzz output directories are numbered, and mainrained in the
`makefile-fuzz` and the `crashes*.sh` scripts.

To verify against regressions either run the binaries against all old
crashes with `make -f makefile-fuzz` or run the scripts seperately,
like `./crashes20.sh`

Usually fuzzing is done on seperate machines, rsync the results (hangs
and crashes) to your local machine regularly.

Get afl++ at https://github.com/vanhauser-thc/AFLplusplus
and be sure to `make -C llvm_mode`, the clang-devel package is needed for this.

I usually run the fuzzer jobs on the big machine with `-M m1`, `-S s1`
and `-S s2 -R` arguments, first the master, then a default slave, and a
second slave with radare. The forth CPU is left alone.
On the laptop I run the fuzzer not with the performance CPU governor.
