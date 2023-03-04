/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INT = 258,                     /* INT  */
    FLOAT = 259,                   /* FLOAT  */
    DOUBLE = 260,                  /* DOUBLE  */
    CHAR = 261,                    /* CHAR  */
    FOR = 262,                     /* FOR  */
    WHILE = 263,                   /* WHILE  */
    DO = 264,                      /* DO  */
    IF = 265,                      /* IF  */
    ELSE = 266,                    /* ELSE  */
    INCLUDE = 267,                 /* INCLUDE  */
    MAIN = 268,                    /* MAIN  */
    ID = 269,                      /* ID  */
    NUMBER = 270,                  /* NUMBER  */
    HEADER = 271,                  /* HEADER  */
    GREATEREQ = 272,               /* GREATEREQ  */
    LESSEREQ = 273,                /* LESSEREQ  */
    EQCOMP = 274,                  /* EQCOMP  */
    NOTEQ = 275,                   /* NOTEQ  */
    INC = 276,                     /* INC  */
    DEC = 277,                     /* DEC  */
    ANDAND = 278,                  /* ANDAND  */
    OROR = 279                     /* OROR  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define INT 258
#define FLOAT 259
#define DOUBLE 260
#define CHAR 261
#define FOR 262
#define WHILE 263
#define DO 264
#define IF 265
#define ELSE 266
#define INCLUDE 267
#define MAIN 268
#define ID 269
#define NUMBER 270
#define HEADER 271
#define GREATEREQ 272
#define LESSEREQ 273
#define EQCOMP 274
#define NOTEQ 275
#define INC 276
#define DEC 277
#define ANDAND 278
#define OROR 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
