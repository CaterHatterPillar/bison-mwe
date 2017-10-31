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
MUL    "*"
LPAREN "("
RPAREN ")"
NUMBER [0-9]+
WSPACE [ \r\n\t]*

%%

{ADD}     { return TOKEN_ADD; }
{MUL}     { return TOKEN_MUL; }
{LPAREN}  { return TOKEN_LPAREN; }
{RPAREN}  { return TOKEN_RPAREN; }
{NUMBER}  { sscanf(yytext, "%d", &yylval->value); return TOKEN_NUMBER; }
{WSPACE}  {}
.         {}

%%
