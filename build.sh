#!/bin/bash

echo"starting BUILD procedure........."

echo"[1/4] Running GPERF...."
gperf tool.gp > keyword_lookup.cpp

echo"[2/4] Running yacc....."
yacc -d tool.y -o yacc_parser.cpp

echo"[3/4] Running flex......"
flex -o lexer.cpp tool.l

echo"[4/4 compiling binary executable.......]"
g++ tool.cpp yacc_paarser.cpp lexer.cpp keyword_lookup.cpp -o my_compiler

if [ $? -eq 0]; then
	echo"=================================="
	echo"SUCCESS: compiler ran succesfully."
	echo"=================================="
else
	echo"-----------------"
	echo"compiler FAILED. "
	echo"-----------------"
fi
