!ifdef __LINUX__
DIRSEP = /
RMFILES = rm -f
RMFILES2 = rm -f
ECHOTO = echo >>
CP = cp
!endif

!ifdef __NT__
!ifdef %ProgramFiles(x86)
!define Win64
!endif
!endif

CC_BASE_PATH = $(WATCOM)
!ifdef __LINUX__
LD = $(CL)
COMMAND_LINK = $(LD) -l=dos -fe=command.exe $(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4) $(LIBS) -\"op map,statics,verbose\"
!else
LD = *wlink debug all opt quiet,symfile,map,statics,verbose
COMMAND_LINK = $(LD) sys dos N command.exe F {$(OBJ1) $(OBJ2) $(OBJ3) $(OBJ4)} L {$(LIBS)}
!endif
LIBPATH = $(CC_BASE_PATH)$(DIRSEP)lib
INCLUDEPATH = -I$(CC_BASE_PATH)$(DIRSEP)h
CC = *wcc -zq -fo=.obj
CL = *wcl -zq -fo=.obj -bcl=dos
AR = *wlib -n -c
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
  owcc -I../suppl $< -o $@
!else
.obj.exe:
  *wlink sys DOS f $< lib $(SUPPL_LIB_PATH)\SUPPL_$(SHELL_MMODEL).LIB op q
!endif
.c.obj:
  $(CC) $< -bt=dos @$(CFG)
