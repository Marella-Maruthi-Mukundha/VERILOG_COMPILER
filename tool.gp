%{
#include<string.h>
#include "yacc_parser.hpp"
extern void yyerror(const char *s);
extern  int rdl_keyword_code(const char*str, unsigned len);
%}

struct rdl_keyword { const char*name; int tokenType; };

%%
module,T_module
endmodule,T_endmodule
in,INPUT
output, OUTPUT
int,INT
float,FLOAT
reg,REG
wire,WIRE
char,CHAR
%%
int rdl_keyword_code(const char*str, unsigned nstr)
{
	const struct rdl_keyword* rc = check_identifier(str,nstr);
	if (rc == NULL)
		return IDENTIFIER;
	else
		return rc->tokenType;
}
