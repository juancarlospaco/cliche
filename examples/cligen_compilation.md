# C Compilation Warnings in Cligen

```console
$ nim --version

Nim Compiler Version 1.6.0 [Windows: amd64]
Compiled at 2021-10-19
Copyright (c) 2006-2021 by Andreas Rumpf

active boot switches: -d:release


$ nim c -f --gc:arc -d:lto cligen_bench.nim

....................................................................................................................
CC: stdlib_digitsutils.nim
CC: stdlib_assertions.nim
CC: stdlib_formatfloat.nim
CC: stdlib_dollars.nim
CC: stdlib_widestrs.nim
CC: stdlib_io.nim
CC: stdlib_system.nim
CC: stdlib_parseutils.nim
CC: stdlib_math.nim
CC: stdlib_enumutils.nim
CC: stdlib_unicode.nim
CC: stdlib_strutils.nim
CC: stdlib_pathnorm.nim
CC: stdlib_dynlib.nim
CC: stdlib_winlean.nim
CC: stdlib_times.nim
CC: stdlib_win_setenv.nim
CC: stdlib_os.nim
CC: stdlib_hashes.nim
CC: ../../../.nimble/pkgs/cligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820/cligen/parseopt3.nim
CC: stdlib_terminal.nim
CC: ../../../.nimble/pkgs/cligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820/cligen/mslice.nim
CC: ../../../.nimble/pkgs/cligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820/cligen/textUt.nim
CC: ../../../.nimble/pkgs/cligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820/cligen/argcvt.nim
CC: stdlib_posix.nim
CC: ../../../.nimble/pkgs/cligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820/cligen/humanUt.nim
CC: stdlib_streams.nim
CC: stdlib_lexbase.nim
CC: stdlib_parsecfg.nim
CC: ../../../.nimble/pkgs/cligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820/cligen.nim
CC: cligen_bench.nim
Hint:  [Link]

C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c: In function 'specifierHighlight_OOZO
OZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764':
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:3420:70: warning: 'nsuSplitCharSet' a
ccessing 32 bytes in a region of size 16 [-Wstringop-overflow=]
 3420 |                                                         colontmpD_ = nsuSplitCharSet(attr, TM__bx9biXaMifIkEvhNEJFOQVA_205, ((NI) -1));
      |                                                                      ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:3420:70: note: referencing argument 2
 of type 'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\stdlib_strutils.nim.c:1816:15: note: in a call to function 'nsuSplitCharSet'
 1816 | N_LIB_PRIVATE N_NIMCALL(tySequence__sM4lkSb7zS6F7OVMvW9cffQ, nsuSplitCharSet)(NimStringV2 s, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw seps, NI maxsplit) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c: In function 'initRstMdSGR_OOZOOZOOZO
nimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_4647':
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:4336:64: warning: 'nsuSplitCharSet' a
ccessing 32 bytes in a region of size 16 [-Wstringop-overflow=]
 4336 |                                                 colontmpD__2 = nsuSplitCharSet(colontmpD_, TM__bx9biXaMifIkEvhNEJFOQVA_205, ((NI) -1));
      |                                                                ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:4336:64: note: referencing argument 2
 of type 'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\stdlib_strutils.nim.c:1816:15: note: in a call to function 'nsuSplitCharSet'
 1816 | N_LIB_PRIVATE N_NIMCALL(tySequence__sM4lkSb7zS6F7OVMvW9cffQ, nsuSplitCharSet)(NimStringV2 s, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw seps, NI maxsplit) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:4346:64: warning: 'nsuSplitCharSet' a
ccessing 32 bytes in a region of size 16 [-Wstringop-overflow=]
 4346 |                                                 colontmpD__4 = nsuSplitCharSet(colontmpD__3, TM__bx9biXaMifIkEvhNEJFOQVA_205, ((NI) -1));
      |                                                                ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:4346:64: note: referencing argument 2
 of type 'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\stdlib_strutils.nim.c:1816:15: note: in a call to function 'nsuSplitCharSet'
 1816 | N_LIB_PRIVATE N_NIMCALL(tySequence__sM4lkSb7zS6F7OVMvW9cffQ, nsuSplitCharSet)(NimStringV2 s, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw seps, NI maxsplit) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c: In function 'apply_OOZOOZOOZOnimbleZpkgsZclig
en4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048Zcligen_309':
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:2623:73: warning: 'nsuSplitCharSet' accessing
32 bytes in a region of size 16 [-Wstringop-overflow=]
 2623 |                                                         colontmpD__23 = nsuSplitCharSet(colontmpD__22, TM__pcg9bmgN0wHE1JvR3RfOjgA_81, ((NI) -1));
      |                                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:2623:73: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\stdlib_strutils.nim.c:1816:15: note: in a call to function 'nsuSplitCharSet'
 1816 | N_LIB_PRIVATE N_NIMCALL(tySequence__sM4lkSb7zS6F7OVMvW9cffQ, nsuSplitCharSet)(NimStringV2 s, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw seps, NI maxsplit) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:2635:73: warning: 'nsuSplitCharSet' accessing
32 bytes in a region of size 16 [-Wstringop-overflow=]
 2635 |                                                         colontmpD__25 = nsuSplitCharSet(colontmpD__24, TM__pcg9bmgN0wHE1JvR3RfOjgA_81, ((NI) -1));
      |                                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:2635:73: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\stdlib_strutils.nim.c:1816:15: note: in a call to function 'nsuSplitCharSet'
 1816 | N_LIB_PRIVATE N_NIMCALL(tySequence__sM4lkSb7zS6F7OVMvW9cffQ, nsuSplitCharSet)(NimStringV2 s, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw seps, NI maxsplit) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:2669:73: warning: 'nsuSplitCharSet' accessing
32 bytes in a region of size 16 [-Wstringop-overflow=]
 2669 |                                                         colontmpD__26 = nsuSplitCharSet(e._kind_3.value, TM__pcg9bmgN0wHE1JvR3RfOjgA_81, ((NI) -1));
      |                                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:2669:73: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\stdlib_strutils.nim.c:1816:15: note: in a call to function 'nsuSplitCharSet'
 1816 | N_LIB_PRIVATE N_NIMCALL(tySequence__sM4lkSb7zS6F7OVMvW9cffQ, nsuSplitCharSet)(NimStringV2 s, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw seps, NI maxsplit) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3101:57: warning: 'specifierHighlight_OOZOOZOO
ZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764' accessing 32 bytes in a region of size 16 [-Wstringop-overf
low=]
 3101 |                                                 T235_ = specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5
349565048ZcligenZhuman85t_2764(e._kind_3.value, Whitespace_pureZstrutils_12, plain, 37, TM__pcg9bmgN0wHE1JvR3RfOjgA_321, TM__pcg9bmgN0wHE1JvR3RfOjgA_323, NIM_FALSE, NIM_FALSE);
      |                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3101:57: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:3346:15: note: in a call to function
'specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764'
 3346 | N_LIB_PRIVATE N_NIMCALL(NimStringV2, specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhu
man85t_2764)(NimStringV2 fmt, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw pctTerm, NIM_BOOL plain, NIM_CHAR pct, NimStringV2 openBkt, NimStringV2 closeBkt, NIM_BOOL keepPct, NIM_BOOL termI
nAttr) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3114:57: warning: 'specifierHighlight_OOZOOZOO
ZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764' accessing 32 bytes in a region of size 16 [-Wstringop-overf
low=]
 3114 |                                                 T237_ = specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5
349565048ZcligenZhuman85t_2764(e._kind_3.value, Whitespace_pureZstrutils_12, plain, 37, TM__pcg9bmgN0wHE1JvR3RfOjgA_325, TM__pcg9bmgN0wHE1JvR3RfOjgA_326, NIM_FALSE, NIM_FALSE);
      |                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3114:57: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:3346:15: note: in a call to function
'specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764'
 3346 | N_LIB_PRIVATE N_NIMCALL(NimStringV2, specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhu
man85t_2764)(NimStringV2 fmt, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw pctTerm, NIM_BOOL plain, NIM_CHAR pct, NimStringV2 openBkt, NimStringV2 closeBkt, NIM_BOOL keepPct, NIM_BOOL termI
nAttr) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3127:57: warning: 'specifierHighlight_OOZOOZOO
ZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764' accessing 32 bytes in a region of size 16 [-Wstringop-overf
low=]
 3127 |                                                 T239_ = specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5
349565048ZcligenZhuman85t_2764(e._kind_3.value, Whitespace_pureZstrutils_12, plain, 37, TM__pcg9bmgN0wHE1JvR3RfOjgA_328, TM__pcg9bmgN0wHE1JvR3RfOjgA_329, NIM_FALSE, NIM_FALSE);
      |                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3127:57: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:3346:15: note: in a call to function
'specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764'
 3346 | N_LIB_PRIVATE N_NIMCALL(NimStringV2, specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhu
man85t_2764)(NimStringV2 fmt, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw pctTerm, NIM_BOOL plain, NIM_CHAR pct, NimStringV2 openBkt, NimStringV2 closeBkt, NIM_BOOL keepPct, NIM_BOOL termI
nAttr) {
      |               ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3140:57: warning: 'specifierHighlight_OOZOOZOO
ZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764' accessing 32 bytes in a region of size 16 [-Wstringop-overf
low=]
 3140 |                                                 T241_ = specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5
349565048ZcligenZhuman85t_2764(e._kind_3.value, Whitespace_pureZstrutils_12, plain, 37, TM__pcg9bmgN0wHE1JvR3RfOjgA_331, TM__pcg9bmgN0wHE1JvR3RfOjgA_332, NIM_FALSE, NIM_FALSE);
      |                                                         ^
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen.nim.c:3140:57: note: referencing argument 2 of type
'NU8 *'
C:\Users\dev\nimcache\cligen_bench_d\@m..@s..@s..@s.nimble@spkgs@scligen-1.5.19-bfe4f99a16ace2164fe40d40866e4951bed51820@scligen@shumanUt.nim.c:3346:15: note: in a call to function
'specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhuman85t_2764'
 3346 | N_LIB_PRIVATE N_NIMCALL(NimStringV2, specifierHighlight_OOZOOZOOZOnimbleZpkgsZcligen4549O53O495745bfe52f5757a4954ace50495452fe5248d5248565454e52575349bed5349565048ZcligenZhu
man85t_2764)(NimStringV2 fmt, tySet_tyChar__nmiMWKVIe46vacnhAFrQvw pctTerm, NIM_BOOL plain, NIM_CHAR pct, NimStringV2 openBkt, NimStringV2 closeBkt, NIM_BOOL keepPct, NIM_BOOL termI
nAttr) {
      |               ^

Hint: gc: arc; opt: none (DEBUG BUILD, `-d:release` generates faster code)
69059 lines; 5.058s; 176.27MiB peakmem; proj: C:\Users\dev\code\cliche\bench\cligen_bench.nim; out: C:\Users\dev\code\cliche\bench\cligen_bench.exe [SuccessX]

$
```
