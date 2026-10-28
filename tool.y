%{
#include<stdio.h>
#include<string.h>
#include<map>
#include<string>
extern int yylineno;
extern int yylex();
extern void yyerror(const char *s);


struct SymbolInfo {
	int type;
	int line;
};

std::map<std::string, SymbolInfo> symbol_table;
int current_decl_type;
void declare_variable(const char* name, int type)
{
	std::string key(name);
	auto it = symbol_table.find(key);
	if(it != symbol_table.end()){
		printf("Error: '%s' alredy declared (first seen at line %d), redeclared at line %d\n",name, it->second.line, yylineno);
	}else {
		symbol_table[key] = { type, yylineno };
	}
}

%}
%union{
	char* sval;
	int ival;
}

%token udp_description T_module T_endmodule LPAR RPAR SEMI Numbers 
%token INT FLOAT CHAR SIGNED UNSIGNED REG WIRE INPUT OUTPUT ASSIGN
%token <sval> IDENTIFIER
%type <ival> TYPE_SPEC


%%
start:design_desc
     |
;
design_desc:module_description
	   |udp_description
;
module_description:T_module IDENTIFIER LPAR port_list_opt RPAR SEMI module_items_opt T_endmodule
;
port_list_opt:
	     |port_list
;
port_list:
	 IDENTIFIER
	 |port_list ',' IDENTIFIER
;
//port_decleration:
//		TYPE_SPEC IDENTIFIER
//;
//VARIABLE_SPEC:
//	     IDENTIFIER
//	     | VARIABLE_SPEC ',' IDENTIFIER
//;
TYPE_SPEC:
	 INT	{ $$ = INT; }
	|FLOAT	{ $$ = FLOAT; }
	|CHAR	{ $$ = CHAR; }
	|SIGNED	{ $$ = SIGNED; }
	|UNSIGNED	{ $$ = UNSIGNED; }
	|REG	{ $$ = REG; }
	|WIRE	{ $$ = WIRE; }
	|INPUT	{ $$ = INPUT; }
	|OUTPUT	{ $$ = OUTPUT; }
;
module_items_opt:
		|module_items
;
module_items:module_item
	    |module_items module_item
;
module_item:TYPE_SPEC { current_decl_type = $1; } variable_list SEMI
;
variable_list:
	  IDENTIFIER		{ declare_variable($1,current_decl_type); }
	|variable_list ',' IDENTIFIER	{ declare_variable($3,current_decl_type); }
;
%%
void yyerror (const char*s){
printf("%s at line %d\n", s, yylineno);
}
