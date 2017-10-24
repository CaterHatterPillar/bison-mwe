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

TESTS:=\
  test_add \
  test_mul \
  test_par \
  test_val \
  test_wsp

$(TESTS): bison_calc
$(TESTS): RES = "25"

test_add: EXPR = "5 + 20"
test_mul: EXPR = "5 * 5"
test_par: EXPR = "5 * \(2 + 3\)"
test_val: EXPR = "25"
test_wsp: EXPR = "  5 * 4  +  5"

ERROR = echo "$$? != $(RES) ($(EXPR))"
test_%:
	./$< $(EXPR); if [ "$$?" -ne $(RES) ]; then $(ERROR); exit 1; fi

all: $(TESTS)
.PHONY: all
