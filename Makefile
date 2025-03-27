TARGET = horton

CC = gcc

COPTS = -std=gnu99 -Wall -O3 -flto=auto -fopenmp \
		-static-libgcc \
		-fwhole-program -march=x86-64 -mtune=generic -funroll-loops -fPIC \
		-Wall
        -Wextra
        -Wunused-variable
        -Wunused-parameter
        -Wunused-function
        -Wdeprecated-declarations
        -Wconversion
        -Wreturn-type
        -Wformat \
		-s -ffunction-sections -fdata-sections -Wl,--gc-sections
COPTS += -Wpedantic -Werror

SRCS = src/main.c

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(COPTS) -o $(TARGET) $(SRCS)

clean:
	rm -f $(TARGET)
