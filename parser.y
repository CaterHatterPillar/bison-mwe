%{

#include "expression.h"
#include "parser.h"
#include "lexer.h"  // after parser.h

int yyerror(Expression **e, yyscan_t scanner, const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    return 0;
}

%}

%code requires {

typedef void* yyscan_t;

}

%defines "parser.h"
%output "parser.c"

%define api.pure
%define parse.error verbose
%lex-param    { yyscan_t scanner }
%parse-param  { Expression **expression }
%parse-param  { yyscan_t scanner }

%union {
    int value;
    Expression *expression;
}

%left '*' TOKEN_MUL
%left '+' TOKEN_ADD
%left '-' TOKEN_SUB
%left '/' TOKEN_DIV

%token TOKEN_LPAREN
%token TOKEN_RPAREN
%token TOKEN_ADD
%token TOKEN_DIV
%token TOKEN_MUL
%token TOKEN_SUB
%token <value> TOKEN_NUMBER

%type <expression> expr

%%

input
    : expr { *expression = $1; }
    ;

expr
    : expr[L] TOKEN_ADD expr[R] { $$ = allocOperation(Operation_ADD, $L, $R); }
    | expr[L] TOKEN_DIV expr[R] { $$ = allocOperation(Operation_DIV, $L, $R); }
    | expr[L] TOKEN_MUL expr[R] { $$ = allocOperation(Operation_MUL, $L, $R); }
    | expr[L] TOKEN_SUB expr[R] { $$ = allocOperation(Operation_SUB, $L, $R); }
    | TOKEN_LPAREN expr[E] TOKEN_RPAREN { $$ = $E; }
    | TOKEN_NUMBER { $$ = allocNumber($1); }
    ;

%%
