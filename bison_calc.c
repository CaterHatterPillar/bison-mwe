#include "expression.h"
#include "parser.h"
#include "lexer.h"  // after parser.h

#include <stdio.h>

Expression *ast(const char *s) {
    yyscan_t scanner;
    if (yylex_init(&scanner)) {
        return NULL;
    }

    YY_BUFFER_STATE state = yy_scan_string(s, scanner);

    Expression *e;
    if (yyparse(&e, scanner)) {
        return NULL;
    }

    yy_delete_buffer(state, scanner);
    yylex_destroy(scanner);

    return e;
}

int eval(Expression *e) {
    switch(e->op) {
    case Operation_ADD:
        return eval(e->l) + eval(e->r);
    case Operation_DIV:
        return eval(e->l) / eval(e->r);
    case Operation_MUL:
        return eval(e->l) * eval(e->r);
    case Operation_SUB:
        return eval(e->l) - eval(e->r);
    case Operation_VAL:
        break;
    }
    return e->value;
}

char *cmd_expression(int argc, char *argv[]) {
    int len = 0;
    for (int i = 1; i < argc; ++i) {
        len += strlen(argv[i]);
    }

    char *expression = malloc(len);
    for (int i = 1; i < argc; ++i) {
        strcat(expression, argv[i]);
    }

    return expression;
}

int main(int argc, char *argv[]) {
    char *expression = cmd_expression(argc, argv);
    Expression *e = ast(expression);

    int result = 0;
    if (e) {
        result = eval(e);
        freeExpression(e);
    }

    free(expression);
    return result;
}
