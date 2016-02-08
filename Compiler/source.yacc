%{
#include<stdio.h>
int yyerror(char *s);
%}

%token tID
%token tPLUS tMOINS tFOIS tMOD tDIV tEG
%token tPO tPF 
%token tAO tAF
%token tEGALITE tOU tET tSUP tSUPEG tINF tINFEG
%token tNON
%token tIF tWHILE
%token tINT
%token tNB
%token tRETURN
%token tPV tVIR

%union{int value; char * variable;}

%left tPLUS tMOINS
%right tFOIS tDIV tEG

%start Prg
%%
Prg : Dfct Prg
	| Dfct;

Dfct : tINT tID tPO PARAMS tPF BODY;

PARAMS : PARAM tVIR PARAMS
		| PARAM
		|;

PARAM : tINT tID;

BODY : tAO DECLARATIONS INSTRUCTIONS RETURN tAF;

DECLARATIONS : tINT SUITEDECLARATIONS tPV DECLARATION
			| ;

SUITEDECLARATIONS : DECLARATION tVIR SUITEDECLARATIONS
				|	DECLARATION;

DECLARATION : tID 
			| AFFECTATION;
			
AFFECTATION : tID tEG EXPARITHMETIQUE tPV;

INSTRUCTIONS : 	AFFECTATION INSTRUCTIONS
			| 	WHILE INSTRUCTIONS
			|	IF INSTRUCTIONS	
			|	RETURN
			|;

EXPARITHMETIQUE : EXPARITHMETIQUE tPLUS EXPARITHMETIQUE
				| EXPARITHMETIQUE tMOINS EXPARITHMETIQUE
				| EXPARITHMETIQUE tFOIS EXPARITHMETIQUE
				| EXPARITHMETIQUE tDIV EXPARITHMETIQUE
				| EXPARITHMETIQUE tMOD EXPARITHMETIQUE
				| tPO EXPARITHMETIQUE tPF
				| tNB
				| tID ;

EXPCONDITIONNELLE : EXPCONDITIONNELLE tOU EXPCONDITIONNELLE 
				| 	EXPCONDITIONNELLE tET EXPCONDITIONNELLE
				| 	EXPCONDITIONNELLE tINFEG EXPCONDITIONNELLE
				| 	EXPCONDITIONNELLE tINF EXPCONDITIONNELLE
				| 	EXPCONDITIONNELLE tSUPEG EXPCONDITIONNELLE
				| 	EXPCONDITIONNELLE tSUP EXPCONDITIONNELLE
				| 	EXPCONDITIONNELLE tEGALITE EXPCONDITIONNELLE
				| 	tPO EXPCONDITIONNELLE tPF
				| 	tNON EXPCONDITIONNELLE
				| 	EXPARITHMETIQUE;

IF : tIF tPO EXPCONDITIONNELLE tPF BODY;

WHILE : tWHILE tPO EXPCONDITIONNELLE tPF BODY;

RETURN : tRETURN EXPARITHMETIQUE tPV
		 tRETURN tID tPV
		| tRETURN tPV;

/*PRINT : tPRINT STRING;*/


%%
int yyerror(char *s) {
 fprintf(stderr,"%s\n",s);
}

int main(void) {
  yyparse();
}
