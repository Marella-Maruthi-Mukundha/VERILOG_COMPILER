%{
#include<stdio.h>
#include<string.h>
#include"yacc_parser.hpp"
extern int rdl_keyword_code(const char* str, unsigned nstr);
//void yyerror(const char *s);
%}
%option noyywrap
%option yylineno

%%
[ \t\n\r]+	{ }
[0-9]+		{ return Numbers;}

"module"	{ return T_module;}
"endmodule"	{ return T_endmodule;}
"int"		{ return INT;}
"float"		{ return FLOAT;}
"char"		{ return CHAR;}
"unsigned"	{ return UNSIGNED;}
"reg"		{ return REG;}
"in"		{ return INPUT;}
"output"	{ return OUTPUT;}
"wire"		{ return WIRE;}
"="		{ return ASSIGN;}
","		{ return ',';}
";"		{ return SEMI;}
"("		{ return LPAR;}
")"		{ return RPAR;}

[a-zA-Z0-9][a-zA-Z0-9]*	{
				int rc = rdl_keyword_code(yytext, yyleng);
				if (rc == IDENTIFIER)
					yylval.sval = strdup(yytext);
				return rc;
}

%%
