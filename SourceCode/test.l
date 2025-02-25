%{
    	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
    	#include "test.tab.h"
%}


%%

","                             	{return COMMA;}
"."                             	{return DOT;}
"-"                             	{return DASH;}
[0-9]+                          	{yylval.Intvar = atoi(yytext);return NUMBER;}


"Rm."                           	{return ROOM;}
[0-9]+"F."(("-")?([0-9])+)?     	{yylval.str = strdup(yytext);return FLOOR;}
"No."                           	{return NO;}
[0-9]+"-"([0-9])+               	{yylval.str = strdup(yytext);return DASHNUMBER;}
"Aly."                          	{return ALLEY;}
"Ln."                           	{return LANE;}
"Sec."                          	{return SEC;}
[NWES]|"1st"|"2nd"|"3rd"|[4-9]+"th"     {yylval.str = strdup(yytext);return DIR;}
"Rd."                           	{return ROAD;}
"Dist."                         	{return DIST;}
"Township"                      	{return TOWNSHIP;}
"County"                        	{return COUNTY;}
"City"                          	{return CITY;}
"\(R.O.C.\)"                    	{return COUNTRY;}

\n                              	{return EOL;}
[a-zA-Z_0-9]*                   	{yylval.str = strdup(yytext);return WORD;}
[ \t]                           	{/*空白忽略*/}
.                               	{printf("非法字元%c\n", *yytext);}

%%

