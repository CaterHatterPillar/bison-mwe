#include "expression.h"

#include <stdlib.h>

Expression *allocExpression() {
    return calloc(1, sizeof(Expression));
}

Expression *allocNumber(int value) {
    Expression *number = allocExpression();
    if (number) {
        number->op = Operation_VAL;
        number->value = value;
    }
    return number;
}

Expression *allocOperation(Operation op, Expression *l, Expression *r) {
    Expression *operation = allocExpression();
    if (operation) {
        operation->l = l;
        operation->r = r;
        operation->op = op;
    }
    return operation;
}

void freeExpression(Expression *e) {
    if (!e) {
        return;
    }

    freeExpression(e->l);
    freeExpression(e->r);
    free(e);
}
