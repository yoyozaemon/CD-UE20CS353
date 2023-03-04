%{
//NAME: Vijay J
//SRN: PES2UG20CS815
//SECTION: J
	#include "sym_tab.c"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#define YYSTYPE char*
	int type=-1;	//initial declaration of type for symbol table
	char* vval="~";	//initial declaration of value for symbol table
	int vtype=-1;	//initial declaration for type checking for symbol table
	int scope=0;	//initial declaration for scope
	int err=0;	//Initial declaration for error
	void yyerror(char* s); // error handling function
	int yylex(); // declare the function performing lexical analysis
	int arraysize=1; //initial size of array
	extern int yylineno; // track the line number
	extern char* yytext; // track the token 

%}
/* declare tokens */
%token T_INT T_CHAR T_DOUBLE T_WHILE  T_INC T_DEC   T_OROR T_ANDAND T_EQCOMP T_NOTEQUAL T_GREATEREQ T_LESSEREQ T_LEFTSHIFT T_RIGHTSHIFT T_PRINTLN T_STRING  T_FLOAT T_BOOLEAN T_IF T_ELSE T_STRLITERAL T_DO T_INCLUDE T_HEADER T_MAIN T_ID T_NUM T_FOR T_OR T_AND T_INCR T_DECR

/* specify start symbol */
%start START


%%
START : PROG { if(err==0) printf("Valid syntax\n");
	 YYACCEPT; }	/* If program fits the grammar, syntax is valid */
        ;						/* Anything within {} is C code, it is the action corresponding to the 							production rule */


PROG : T_INCLUDE '<' T_HEADER '>' PROG	/* include header */
	| MAIN PROG    /* main function */
	| DECLR ';' PROG   /* declarations */
	| ASSGN ';' PROG   /* assignments  */
	| DEC_ASGN';' PROG
	| FOR PROG
	| DO PROG
	| EXPR ';' PROG
	
	|	/* end of programs */
	;	  

FOR : T_FOR '(' DEC_ASGN';'T_ID REL_OP EXPR ';' T_ID UNARY_OP ')' '{'{scope++;} STMT '}'{scope--;};
DEC_ASGN : {printf(" ");} TYPE LISTVAR;
/* Grammar for variable declaration */
DECLR : TYPE LISTVAR 
	| TYPE ARRAY
	;	/* always terminate with a ; */
ARRAY : T_ID BRACKET {
		if(check_sym_tab($1))	//if variable is in table then variable is being re-declared
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				}
				else
				{
				insert_symbol($1,size(type)*arraysize,type,yylineno,scope);
				arraysize=1;	//revert to default for checking
				type=-1;
				}
		}
	;
BRACKET : '[' T_NUM ']' BRACKET { arraysize*=atoi($2);}
	| 
	;
LISTVAR : LISTVAR ',' VAR 
	  | VAR
	  ;

VAR: T_ID '=' EXPR 	{
				if(check_sym_tab($1))	//if variable is in table then variable is being re-declared
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				}
				else
				{
				insert_symbol($1,size(type),type,yylineno,scope);
				insert_val($1,vval,yylineno);
				vval="~";	//revert to default for checking
				type=-1;
				}
			}
     | T_ID 		{
				if(check_sym_tab($1))	//if variable is in table then variable is being re-declared
				{
					printf("Variable %s already declared\n",$1);
					yyerror($1);
				}
				else{
				insert_symbol($1,size(type),type,yylineno,scope);
				type=-1;	//revert to default for checking
				}
			}	 
	
TYPE : T_INT {type = INT;}		//INT=2
       | T_FLOAT {type = FLOAT;}	//FLOAT=3
       | T_DOUBLE {type = DOUBLE;}	//DOUBLE=4
       | T_CHAR {type = CHAR;}		//CHAR=1
       ;
    
/* Grammar for assignment */   
ASSGN : T_ID {type=retrieve_type($1);}'=' EXPR 	{
				if(!check_sym_tab($1))	//if variable not declared then value cannot be assigned
				{
					printf("Variable %s not declared\n",$1);
					yyerror($1);
				}
				insert_val($1,vval,yylineno);
				vval="~";		//to make sure previous values aren't inserted into other identifiers
				type=-1;		//revert to default for checking
			}
	;

EXPR : EXPR REL_OP E  
       | E {vval=$1;}
       | EXPR LOGICAL_OP E
	| E UNARY_OP
	| UN_OP E
       ;

/* Expression Grammar */	   
E : E '+' T 	{ 
			if(vtype==2)				//integer
				sprintf($$,"%d",(atoi($1)+atoi($3)));
			else if(vtype==3)			//float or double
				sprintf($$,"%lf",(atof($1)+atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | E '-' T 	{ 
			if(vtype==2)				//integer
				sprintf($$,"%d",(atoi($1)-atoi($3)));
			else if(vtype==3)			//float or double
				sprintf($$,"%lf",(atof($1)-atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | T {$$=$1;}
    ;
	
	
T : T '*' F 	{ 
			if(vtype==2)				//integer
				sprintf($$,"%d",(atoi($1)*atoi($3)));
			else if(vtype==3)			//float or double
				sprintf($$,"%lf",(atof($1)*atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | T '/' F 	{ 
			if(vtype==2)				//integer
				sprintf($$,"%d",(atoi($1)/atoi($3)));
			else if(vtype==3)			//float or double
				sprintf($$,"%lf",(atof($1)/atof($3)));
			else
			{
				printf("Character used in arithmetic\n");
				yyerror($$);
				$$="~";
			}
		}
    | F {$$=$1;}
    ;

F : '(' EXPR ')'
    | T_ID 	{
			if(check_sym_tab($1))		//check if variable is in symbol table
			{
				char* check=retrieve_val($1);
				if(check=="~")		//if variable has no value then can't be used for assignment
				{
					printf("Variable %s not initialised",$1);
					yyerror($1);
				}
				else
				{	
					$$=strdup(check);
					vtype=type_check(check);	
					if(vtype!=type && type!=-1)	//checks for matching type
					{
						printf("Mismatch type\n");
						yyerror($1);
					}	
				}
			}
			else
			{
					printf("Variable %s not declared\n",$1);
					yyerror($1);
			}
		}
    | T_NUM 	{
    			$$=strdup($1); 
    			vtype=type_check($1);
    			if(vtype!=type && type!=-1)	//checks for matching type
			{
				printf("Mismatch type\n");
				yyerror($1);
			}
		}
    | T_STRLITERAL {
    			$$=strdup($1); 
    			vtype=1;
			if(vtype!=type)		//checks for matching type
			{
				printf("Mismatch type\n");	
				yyerror($1);
			}
		}
    ;

REL_OP :   T_LESSEREQ
	   | T_GREATEREQ
	   | '<' 
	   | '>' 
	   | T_EQCOMP
	   | T_NOTEQUAL
	   ;	

LOGICAL_OP:T_AND
	|T_OR
	|'!'
	;
	
UNARY_OP: T_INCR
	|T_DECR
	;
	
UN_OP   : T_INCR
	|T_DECR
	|'-'
	|'+'
	|'!'
	;
/* Grammar for main function */
MAIN : TYPE T_MAIN '(' EMPTY_LISTVAR ')' '{' {scope++;} STMT '}' {scope--;};


/* argument list can be empty, or have a list of variables */
EMPTY_LISTVAR : LISTVAR
		|	/* similar to lambda */
		;


/* statements can be standalone, or parts of blocks */

STMT : STMT_NO_BLOCK STMT
	| BLOCK {scope++;} STMT {scope--;}
	| FOR PROG
	| DO
	| EXPR ';'
	| DEC_ASGN ';' 
	|
	;
	
%nonassoc T_IFX;
%nonassoc T_ELSE;

STMT_NO_BLOCK : DECLR ';'
	| ASSGN ';'
	| T_IF COND {scope++;} STMT {scope--;} %prec T_IFX   /* if loop */
	| T_IF COND {scope++;} STMT {scope--;} T_ELSE STMT   /* if else loop */
	| WHILE
	;

DO    : T_DO BLOCK WHILE
      ;
BLOCK : '{' {scope++;} STMT '}' {scope--;};


/* Condition can be an expression or an assignment */
COND : EXPR  
       | ASSGN
       ;
      
/* Grammar for while loop */
WHILE : T_WHILE '(' COND ')' WHILE_2;
	

/* Condition can be an expression or an assignment */  
COND : EXPR
	| ASSGN
	;
	
// while loop may or may not have block of statements  
WHILE_2 : '{'{scope++;} STMT '}'{scope--;}
	| ';'
	;

%%


/* error handling function */
void yyerror(char* s)
{
	err+=1;
	printf("Error :syntax error,line number:%d,token:%s \n",yylineno,yytext);
}
int yywrap()
{
    return(1);
}

/* main function - calls the yyparse() function which will in turn drive yylex() as well */
int main(int argc, char* argv[])
{
	t=init_table();
	//printf("here \n");
	yyparse();
	display_sym_tab();
	return 0;

}
