%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
%}

digit       [0-9]
identifier  [a-zA-Z_][a-zA-Z0-9_]*
whitespace  [ \t\n]+

%%

"while"     { return WHILE; }
"print"     { return PRINT; }

"("         { return '('; }
")"         { return ')'; }
"{"         { return '{'; }
"}"         { return '}'; }
";"         { return ';'; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"="         { return '='; }

{digit}+    {
                yylval.ival = atoi(yytext);
                return INTEGER;
            }

{identifier} {
                yylval.sval = strdup(yytext);
                return IDENTIFIER;
            }

{whitespace}    { /* skip whitespace */ }

.           { printf("Unknown character: %s\n", yytext); exit(1); }

%%

int yywrap(void) {
    return 1;
}