##
## EPITECH PROJECT, 2022
## Makefile
## File description:
## Mini LibC
##

.PHONY: all clean fclean re

RM					=	rm -f

ASM_COMPIL			=	nasm
ASM_COMPIL_FLAGS	=	-f elf64

LINKER				=	ld
LINKER_FLAGS		=	-fPIC -shared

LIB_FILES_PATH		=	lib/
LIB_NAME			=	libasm.so

LIB_FILES			=	strlen.asm		\
						strchr.asm		\
						strrchr.asm		\
						memset.asm		\
						memcpy.asm		\
						strcmp.asm		\
						memmove.asm		\
						strncmp.asm		\
						strcasecmp.asm	\
						strstr.asm		\
						strpbrk.asm		\
						strcspn.asm

SRC					=	$(addprefix $(LIB_FILES_PATH), $(LIB_FILES))
OBJ					=	$(SRC:.asm=.o)

all: $(LIB_NAME)

$(LIB_NAME): $(OBJ)
	$(LINKER) $(LINKER_FLAGS) -o $(LIB_NAME) $(OBJ)

# * ... Thank you fellow - https://bit.ly/3vcyk1d
%.o:	%.asm
	$(ASM_COMPIL) $(ASM_COMPIL_FLAGS) $< -o $@

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(LIB_NAME)

re: fclean all
