#!/bin/bash

lex lexer.l
yacc -d parser.y -Wno
gcc -g y.tab.c lex.yy.c 




