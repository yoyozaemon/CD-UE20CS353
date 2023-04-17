compiler: y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c

y.tab.c: parser.y
	yacc -d parser.y

lex.yy.c: lexer.l
	lex lexer.l

clean:
	rm *.yy.c y.tab.h y.tab.c a.out
