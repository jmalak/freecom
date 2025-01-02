CFG_DEPENDENCIES = makefile.mak

TOP = ..
!include "$(TOP)/config.mak"

all : $(CFG)

clean :
	clnsuppl.bat
