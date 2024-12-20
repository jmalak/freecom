CFG_DEPENDENCIES = command.mak ../strings.h

TOP=..
!include "$(TOP)/config.mak"

all: command.exe

OBJ1 =	$(OBJC0) cb_catch.obj termhook.obj
!if $(XMS_SWAP)0 == 0
OBJ2 =	dummies.obj
!else
OBJ2 =	xms_crit.obj\
	xms_brk.obj\
	xms_2e.obj\
	cswap.obj\
	cswapc.obj
!endif
OBJ3 =	batch.obj\
	cmdtable.obj\
	command.obj\
	expalias.obj\
	init.obj\
	kswap.obj\
	loadhigh.obj\
	module.obj
OBJ4 =	redir.obj\
	ver.obj
LIBS = 	..$(DIRSEP)cmd$(DIRSEP)cmds.lib ..$(DIRSEP)lib$(DIRSEP)freecom.lib \
..$(DIRSEP)strings$(DIRSEP)strings.lib \
$(SUPPL_LIB_PATH)$(DIRSEP)suppl_$(SHELL_MMODEL).lib $(LIBC)

ECHOTO0 = ..$(DIRSEP)scripts$(DIRSEP)echoto.bat

command.rsp : $(ECHOTO0)
!if "$(COMPILER)" == "WATCOM"
	$(RMFILES) $@
	%append $@ name command.exe
	%append $@ opt map
	for %f in ($(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4)) do %append $@ file %f
	for %f in ($(LIBS)) do %append $@ lib %f
!else
	$(RMFILES) command.rsp
	$(ECHOTO0) command.rsp $(OBJ1)+
	$(ECHOTO0) command.rsp $(OBJ2)+
	$(ECHOTO0) command.rsp $(OBJ3)+
	$(ECHOTO0) command.rsp $(OBJ4)
	$(ECHOTO0) command.rsp command.exe
	$(ECHOTO0) command.rsp command.map
	$(ECHOTO0) command.rsp $(LIBS)
!endif

command.exe : $(CFG) $(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4) $(LIBS) $(LD_DEPS)
	$(LD)
