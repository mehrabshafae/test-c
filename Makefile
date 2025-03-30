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
