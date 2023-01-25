a.exe: y.tab.c lex.yy.c
	gcc y.tab.c lex.yy.c
y.tab.c: parser.y
	bison -dy parser.y -Wno
lex.yy.c: lexer.l  y.tab.h
	flex lexer.l
	
