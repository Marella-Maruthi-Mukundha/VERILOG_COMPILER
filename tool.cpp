#include<stdio.h>
#include<string.h>
#include "yacc_parser.hpp"

extern FILE* yyin;
extern int yyparse();

int main (int argc, char *argv[])
{
	const char* filename = NULL;

	for(int i=1; i < argc; i++){
		if(!strcmp(argv[i], "-f") && i+1 <  argc){
			filename = argv[i+1];
		}
	}
	if(!filename){
		printf("Usage: %s -f <verilog_file>\n", argv[0]);
		return 1;
	}
	yyin = fopen(filename, "r");
	if (!yyin){
		printf("could not open file %s\n", filename);
		return 1;
	}
	int result = yyparse();
	fclose(yyin);

	if(result == 0)
		printf("parsing successful!\n");
	return result;
} 
