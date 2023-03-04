%{
//Name: Vijay J
//SRN: PES2UG20CS815
//SECTION: J
#define YYSTYPE char*  
#include "y.tab.h"  
#include <stdio.h>
extern void yyerror(const char *);  
%}

digit [0-9]
letter [a-zA-Z]
id {letter}({letter}|{digit})*
digits {digit}+
opFraction (\.{digits})?  
opExponent ([Ee][+-]?{digits})?
number {digits}{opFraction}{opExponent}
%option yylineno
%%  // Separates definitions section from rules section

\/\/(.*)  ;	  
[\t\n]  ;	
"int"    {return T_INT;}
"char"   {return T_CHAR;}
"double" {return T_DOUBLE;}
"float"  {return T_FLOAT;}
"while"  {return T_WHILE;}
"if"	 {return T_IF;}
"else"	 {return T_ELSE;}
"do"	 {return T_DO;}
"#include"  {return T_INCLUDE;}
"main"  {return T_MAIN;}
"for" {return T_FOR;}
\".*\"  {yylval=strdup(yytext); return T_STRLITERAL;}
"=="    {return T_EQCOMP;}
"++" 	{return T_INCR;}
"--" 	{return T_DECR;}
"!="    {return T_NOTEQUAL;}
">="    {return T_GREATEREQ;}
"<="    {return T_LESSEREQ;}
"("     {return *yytext;}
")"     {return *yytext;}
"["     {return *yytext;}
"]"     {return *yytext;}
"."     {return *yytext;}
","     {return *yytext;}  
"{"     {return *yytext;}  
"}"     {return *yytext;} 
"*"     {return *yytext;}
"+"     {return *yytext;}
";"     {return *yytext;}
"-"     {return *yytext;}
"/"     {return *yytext;}
"="     {return *yytext;}
">"     {return *yytext;}
"<"     {return *yytext;}
"||"	{return T_OR;}
"&&"	{return T_AND;}
{number}	{
			yylval=strdup(yytext);  
			return T_NUM;
		}
{id}\.h	{return T_HEADER;}  
{id}        	{
			yylval=strdup(yytext); 
			return T_ID;
		}
.		{} 
%%	
