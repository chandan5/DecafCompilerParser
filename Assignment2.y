%{
#include <cstdio>
#include <iostream>
using namespace std;

    extern "C" int yylex();
	extern "C" int yyparse();
	extern "C" FILE * yyin;
	extern int yylineno;
	void yyerror(const char *s);
%}

%union {
    int ival;
    char *sval;
}

%token SEMICOLON
%token OPEN_PARANTHESIS
%token CLOSE_PARANTHESIS
%token OPEN_SQUAREBRACKET
%token CLOSE_SQUAREBRACKET
%token OPEN_CURLYBRACE
%token CLOSE_CURLYBRACE

%token MAIN
%token FALSE
%token INT
%token BOOLEAN
%token TRUE
%token EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO

// TODO prescedence
%token <sval> IDENTIFIER
%token <ival> INT_VALUE

%%
    program: INT MAIN OPEN_PARANTHESIS CLOSE_PARANTHESIS OPEN_CURLYBRACE
                declarations statements CLOSE_CURLYBRACE
    declarations :  declaration
                |   declaration declarations
    statements :    statement
                |   statement statements
    declaration :   type IDENTIFIER SEMICOLON {cout << "simple declaration complete" << endl;}
                |   type IDENTIFIER OPEN_SQUAREBRACKET INT_VALUE CLOSE_SQUAREBRACKET SEMICOLON {cout << "declaration complete" << endl;}
    statement : SEMICOLON
            |   IDENTIFIER OPEN_SQUAREBRACKET expression CLOSE_SQUAREBRACKET EQUAL expression SEMICOLON {cout << "statement complete" << endl;}
    expression : IDENTIFIER binOP IDENTIFIER
    binOP : addOP
        |   mulOp
    addOP : PLUS
        |   MINUS
    mulOp : MULTIPLY
        |   DIVIDE
        |   MODULO
    type :  INT {cout << "Found int" << endl;}
        |   BOOLEAN


%%

void yyerror (const char *s) {
	std::cerr << "Parse Error on Line : " << yylineno << std::endl << "Message : " << s << std::endl;
	exit(-1);
}

int main(int argc, char*argv[]) {
     if ( argc != 2 ) /* argc should be 2 for correct execution */
     {
        /* We print argv[0] assuming it is the program name */
        printf( "usage: %s filename\n", argv[0] );
        return -1;
     }
     else
     {
        // We assume argv[1] is a filename to open
        FILE *myfile = fopen( argv[1], "r" );
        if (!myfile) {
            cout << "Can't open file: " << argv[1] << endl;
            return -1;
        }
        // set lex to read from it instead of defaulting to STDIN:
        yyin = myfile;
    }
    do {
        yyparse();
    } while (!feof(yyin));

    return 0;
}
