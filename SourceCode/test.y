%{
    #include<stdio.h>
    #include<stdlib.h>
    int yylex(void);
    int yywrap(void);

    extern char* yytext;
    extern ECHO;


%}

%union {
    char* str;
    int Intvar;
}


%token  COMMA DOT DASH
%token  <Intvar>NUMBER
%token  EOL
  
%token  ROOM NO ALLEY LANE SEC ROAD DIST TOWNSHIP COUNTY CITY COUNTRY
%token <str>FLOOR DASHNUMBER WORD DIR

%%

/*calclist:nothing
    |calclist exp EOL{printf("=%d\n", $2);}
;*/

start:EOL{free(yylval.str);}
    |room EOL{free(yylval.str);}/*printf("%s\n", yylval.str);*/
;

room:ROOM NUMBER COMMA floor{printf("room: %d ��\n", $2);}/*��*/
    |floor
;

floor:FLOOR COMMA numeric{printf("floor: %s ��\n", $1);}/*��(���X)*/
    |numeric
;

numeric:NO NUMBER COMMA alley{printf("numeric: %d ��\n", $2);}/*��(���X)*/
    |NO DASHNUMBER COMMA alley{printf("numertic: %s ��\n", $2);}
;

alley:ALLEY NUMBER COMMA lane{printf("alley: %d ��\n", $2);}/*��*/
    |lane
;

lane:LANE NUMBER COMMA part{printf("lane: %d ��\n", $2);}/*��*/
    |part
;

part:SEC NUMBER COMMA road{printf("part: %d �q\n", $2);}/*�q*/
    |road
;

road:WORD DIR DOT ROAD COMMA township{printf("road: %s %s ��\n", $1, $2);}/*��*/
    |WORD DIR ROAD COMMA township{printf("street: %s %s ��\n", $1, $2);}/*��*/
    |WORD ROAD COMMA township{printf("road: %s ��\n", $1);}

;

township:WORD DIST COMMA city{printf("dist: %s ��\n", $1);}/*�m��Township����Dist.*/
    |WORD TOWNSHIP COMMA city{printf("township: %s �m��\n", $1);}
    |WORD CITY COMMA city{printf("city: %s ��\n", $1);}
;

city:WORD CITY NUMBER COMMA country{printf("city: %s ��\n", $1);}/*��City*/  
    |WORD COUNTY NUMBER COMMA country{printf("county: %s ��\n", $1);}/*��County*/
;

country:WORD COUNTRY{printf("��J�a�}��:\ncountry: %s \n", $1);free(yylval.str);break;}/*��a*/
;

%%

main(int argc,char **argv)
{
    yyparse();
}

yyerror(char *s)
{
    fprintf(stderr,"error:%s\n", s);
}