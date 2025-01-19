@echo on
set OUTDIR=build\
cmake -S . -B %OUTDIR%
cmake --build %OUTDIR%