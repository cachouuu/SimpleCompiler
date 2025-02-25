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

room:ROOM NUMBER COMMA floor{printf("room: %d 室\n", $2);}/*室*/
    |floor
;

floor:FLOOR COMMA numeric{printf("floor: %s 樓\n", $1);}/*樓(之幾)*/
    |numeric
;

numeric:NO NUMBER COMMA alley{printf("numeric: %d 號\n", $2);}/*號(之幾)*/
    |NO DASHNUMBER COMMA alley{printf("numertic: %s 號\n", $2);}
;

alley:ALLEY NUMBER COMMA lane{printf("alley: %d 弄\n", $2);}/*弄*/
    |lane
;

lane:LANE NUMBER COMMA part{printf("lane: %d 巷\n", $2);}/*巷*/
    |part
;

part:SEC NUMBER COMMA road{printf("part: %d 段\n", $2);}/*段*/
    |road
;

road:WORD DIR DOT ROAD COMMA township{printf("road: %s %s 路\n", $1, $2);}/*路*/
    |WORD DIR ROAD COMMA township{printf("street: %s %s 街\n", $1, $2);}/*街*/
    |WORD ROAD COMMA township{printf("road: %s 路\n", $1);}

;

township:WORD DIST COMMA city{printf("dist: %s 區\n", $1);}/*鄉鎮Township市區Dist.*/
    |WORD TOWNSHIP COMMA city{printf("township: %s 鄉鎮\n", $1);}
    |WORD CITY COMMA city{printf("city: %s 市\n", $1);}
;

city:WORD CITY NUMBER COMMA country{printf("city: %s 市\n", $1);}/*市City*/  
    |WORD COUNTY NUMBER COMMA country{printf("county: %s 縣\n", $1);}/*縣County*/
;

country:WORD COUNTRY{printf("輸入地址為:\ncountry: %s \n", $1);free(yylval.str);break;}/*國家*/
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