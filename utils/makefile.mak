CFG_DEPENDENCIES = makefile.mak

UTILS_BUILD = 1

TOP = ..
!include "$(TOP)/config.mak"

all: $(CFG) mktools.exe mkctxt.exe chunk.exe mkinfres.exe ptchsize.exe

mktools.exe : mktools.c ../config.h
mkctxt.exe : mkctxt.c
chunk.exe : chunk.c
mkinfres.exe : mkinfres.c ../config.h ../include/command.h ../include/res.h ../include/infores.h ../lib/res_w.c
ptchsize.exe : ptchsize.c ../tools/ptchsize.c