%{

#include "expression.h"
#include "parser.h"

#include <stdio.h>

%}

%option header-file="lexer.h"
%option outfile="lexer.c"

%option bison-bridge

%option warn nodefault

%option reentrant
%option noyywrap
%option never-interactive
%option nounistd

ADD    "+"
DIV    "/"
MUL    "*"
SUB    "-"
LPAREN "("
RPAREN ")"
NUMBER [0-9]+
WSPACE [ \r\n\t]*

%%

{ADD}     { return TOKEN_ADD; }
{DIV}     { return TOKEN_DIV; }
{MUL}     { return TOKEN_MUL; }
{SUB}     { return TOKEN_SUB; }
{LPAREN}  { return TOKEN_LPAREN; }
{RPAREN}  { return TOKEN_RPAREN; }
{NUMBER}  { sscanf(yytext, "%d", &yylval->value); return TOKEN_NUMBER; }
{WSPACE}  {}
.         {}

%%
