DECAF:
	bison -d --verbose Assignment2.y -o Assignment2.tab.cc
	flex -o lex.yy.cc Assignment2.l
	g++ Assignment2.tab.cc lex.yy.cc -ll

