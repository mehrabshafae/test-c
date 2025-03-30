# TARGET = horton-user

# CC = gcc

# COPTS = -std=gnu99 -Wall -fopenmp \
#         -static -static-libgcc \
#         -march=x86-64 -mtune=generic \
#         -Wdeprecated-declarations \
#         -s -Wpedantic

# SRCS = src/user.c

# all: $(TARGET)

# $(TARGET): $(SRCS)
# 	$(CC) $(COPTS) -o $(TARGET) $(SRCS)

# clean:
# 	rm -f $(TARGET)

# .PHONY: all clean

# Kernel

TARGET = horton
CC = gcc
COPTS = -std=gnu99 -Wall -fopenmp \
        -static -static-libgcc \
        -march=x86-64 -mtune=generic \
        -Wdeprecated-declarations \
        -s -Wpedantic
SRCS = src/user.c

KERNEL_MODULE = hello_kernel
KERNEL_SRC = hello_kernel.c
KDIR ?= /lib/modules/$(shell uname -r)/build
PWD = $(shell pwd)

all: $(TARGET) $(KERNEL_MODULE).ko

$(TARGET): $(SRCS)
	$(CC) $(COPTS) -o $(TARGET) $(SRCS)

obj-m := $(KERNEL_MODULE).o

$(KERNEL_MODULE).ko: $(KERNEL_SRC)
	make -C $(KDIR) M=$(PWD) modules

clean:
	rm -f $(TARGET)
	make -C $(KDIR) M=$(PWD) clean

.PHONY: all clean
