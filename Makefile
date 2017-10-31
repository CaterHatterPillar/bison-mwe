SRCS:=\
  bison_calc.c \
  expression.c \
  lexer.c \
  parser.c

CFLAGS:=\
  -Wall \
  -Werror \
  -Wno-unused-function \
  -g

bison_calc: $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $@

lexer.c: lexer.l
	flex $<

parser.c: parser.y lexer.c
	bison $<

JUNK:=\
  bison_calc \
  lexer.c \
  lexer.h \
  parser.c \
  parser.h

clean:
	rm -f $(JUNK)

all: bison_calc
