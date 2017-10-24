#pragma once

typedef enum {
    Operation_ADD,
    Operation_DIV,
    Operation_MUL,
    Operation_SUB,
    Operation_VAL
} Operation;

typedef struct Expression Expression;

struct Expression {
    Expression *l;
    Expression *r;
    Operation op;
    int value;
};

Expression *allocNumber(int value);
Expression *allocOperation(Operation op, Expression *l, Expression *r);
void freeExpression(Expression *e);
