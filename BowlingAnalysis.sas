FILENAME REFFILE ’/folders/myfolders/BowlingScores.xlsx ’ ;

PROC IMPORT DATAFILE=REFFILE DBMS=XLSX
OUT=Bowling ; GETNAMES=YES ;
RUN;

PROC CONTENTS DATA=Bowling ; RUN; PROCMEANSDATA=Bowling NMISSN; RUN;
May 1, 2019
 PROC MEANS DATA=Bowling ; VAR Score Bowler GameNum; RUN;

PROC MEANS DATA=Bowling ; CLASS Bowler;
VAR Score GameNum; RUN;
PROCMEANSDATA=Bowling sum; CLASS Bowler;
VAR Score GameNum; RUN;

PROC UNIVARIATE DATA=Bowling Var Score ;
Normal
Plot ;
Plot ;
RUN;
qqplot Score ;
histogram Score / normal ;
PROC UNIVARIATE DATA=Bowling Normal CLASS Bowler;
Var Score GameNum;
qqplot Score ;
histogram Score / normal ;
RUN;
/∗ Fixed Effects∗/ PROC GLM DATA=Bowling ; CLASS Bowler;
MODEL Score = Bowler;
MEANS Bowler/ LSD BON TUKEY CLDIFF HOVTEST=LEVENE WELCH; OUTPUT OUT=result1 R=residuals P=y hat ;
RUN;
PROCUNIVARIATEDATA=result1 NORMALPLOT; VAR residuals ;
RUN;

PROC SGPLOT DATA=result1 ; scatter x=y hat y=residuals ;
RUN;


/∗ Random Effects∗/ 
PROC GLM DATA = Bowling ;
CLASS Bowler;
MODEL Score = Bowler;
RANDOM Bowler ;
MEANS Bowler/hovtest = levene ; OUTPUTOUT=ResPred P=Yhat R=Ehat; TITLE ’ Results from Proc GLM’ ;
RUN;

PROC UNIVARIATE DATA=ResPred NORMAL PLOT; VAR E h a t ;
RUN;

PROC SGPLOT DATA=ResPred ; scatter x=Yhat y=Ehat;
RUN;

PROC MIXED DATA = Bowling ; CLASS Bowler;
MODEL Score=;
RANDOM Bowler ;
TITLE ’ Results from Proc RUN;
Mixed ’ ;
