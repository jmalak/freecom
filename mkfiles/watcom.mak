!ifdef __LINUX__
DIRSEP = /
RMFILES = rm -f
RMFILES2 = rm -f
ECHOTO = echo >>
ECHOTO0 = echo >>
CP = cp
!endif

!ifdef __NT__
!ifdef %ProgramFiles(x86)
!define Win64
!endif
!endif

CC_BASE_PATH = $(WATCOM)
!ifdef __LINUX__
BINPATH = $(CC_BASE_PATH)/binl
LD = $(CL) -l=dos -fe=command.exe $(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4) $(LIBS) -\"op map,statics,verbose,stack=4k\" $#
!else
!ifdef Win64
BINPATH = $(CC_BASE_PATH)\BINNT
!else
BINPATH = $(CC_BASE_PATH)\BINW
!endif
LD = wlinker /ma/nologo
!endif
LIBPATH = $(CC_BASE_PATH)$(DIRSEP)lib
INCLUDEPATH = -I$(CC_BASE_PATH)$(DIRSEP)h
CC = $(BINPATH)$(DIRSEP)wcc -zq -fo=.obj
CL = $(BINPATH)$(DIRSEP)wcl -zq -fo=.obj -bcl=dos
AR = $(BINPATH)$(DIRSEP)wlib -n -c
LIBLIST = >
ECHOLIB = echo >>

CFG = watcomc.cfg
CFLAGS1 = -os-s-wx

#		*Implicit Rules*
!ifdef __LINUX__
.SUFFIXES:
.SUFFIXES: .c .asm .com .exe .obj
.c.exe:
  gcc -x c -D__GETOPT_H -I../suppl $< -o $@
!else ifdef Win64
.c.exe
  $(BINPATH)\owcc -I../suppl $< -o $@
!else
.obj.exe:
  $(BINPATH)\wlink sys DOS f $< lib $(SUPPL_LIB_PATH)\SUPPL_$(SHELL_MMODEL).LIB op q
!endif
.c.obj:
  $(CC) $< -bt=dos @$(CFG)
