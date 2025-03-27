# TARGET = horton

# CC = gcc

# COPTS = -std=gnu99 -Wall -O3 -flto=auto -fopenmp \
#         -static -static-libgcc \
#         -fwhole-program -march=x86-64 -mtune=generic -funroll-loops -fPIC \
#         -Wextra \
#         -Wunused-variable \
#         -Wunused-parameter \
#         -Wunused-function \
#         -Wdeprecated-declarations \
#         -Wconversion \
#         -Wreturn-type \
#         -Wformat \
#         -s -ffunction-sections -fdata-sections -Wl,--gc-sections \
#         -Wpedantic -Werror

# SRCS = src/main.c

# all: $(TARGET)

# $(TARGET): $(SRCS)
# 	$(CC) $(COPTS) -o $(TARGET) $(SRCS)

# clean:
# 	rm -f $(TARGET)

CC = gcc
CFLAGS = -O3 -flto=auto -fopenmp \
         -Wall -Wextra -Wunused-variable -Wunused-parameter -Wunused-function -Wdeprecated-declarations -Wconversion -Wreturn-type -Wformat
LDFLAGS = 

BUILD_TYPE ?= Debug
ifeq ($(BUILD_TYPE), Release)
    CFLAGS += -fwhole-program -march=x86-64 -mtune=generic -funroll-loops -fPIC -s \
              -ffunction-sections -fdata-sections -Wl,--gc-sections
    LDFLAGS += -static -static-libgcc
endif

SRC = src/main.c
OBJ = $(SRC:.c=.o)

EXECUTABLE_NAME = core$(if $(BUILD_TYPE),-dynamic)

all: $(EXECUTABLE_NAME)

$(EXECUTABLE_NAME): $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(EXECUTABLE_NAME)

.PHONY: all clean
