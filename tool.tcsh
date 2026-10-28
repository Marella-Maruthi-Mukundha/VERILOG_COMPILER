#! /usr/bin/tcsh -f
#
# Build script for the Verilog compiler
# 
echo "Let's Go "


gperf -t -N check_identifier tool.gp > keyword_lookup.cpp
if ($status != 0) then
	echo "gperf failed..........."
	exit 1
endif

# Generate parser
bison -d -o yacc_parser.cpp tool.y
if($status != 0) then
	echo "bison failed.........."
	exit 1
endif

# Generate lexer
flex -o lexer.cpp tool.l
if ($status != 0) then
	echo "flex failed............"
	exit 1
endif

#compile everuthing 
g++ -o a.out tool.cpp lexer.cpp yacc_parser.cpp keyword_lookup.cpp
if ($status != 0) then
	echo "g++ failed"
	exit 1
endif

echo "=========================="
echo "Build succeeded -> ./a.out"
echo "=========================="
