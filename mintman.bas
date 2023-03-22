1 ! save MINTMAN
10 REM Ins{nd av Anders Franz`n <5258>    1985-07-05 01.47.21
100 REM +++++++++++++++++++++++++++++++
110 REM ! Program ....   MINTMAN
120 REM ! Utg}va  1.0    1985-07-04
130 REM ! av (c) Anders Franz`n <5258>
140 REM ! Minne 16 Kbytes
150 REM +++++++++++++++++++++++++++++++
160 REM 
170 REM Detta program simulerar denna
180 REM sommars fluga, herr Mintman, p}
190 REM bildsk{rmen. Man kan spela
200 REM sj{lv ellet l}ta datorn visa
210 REM en l|sning. Programmet g|r
220 REM inga anspr}k p} att visa den
230 REM b{sta l|sningen. En "{kta"
240 REM Mintman {r kanske det b{sta
250 REM om man ligger p} stranden och
260 REM latar sig.
270 REM 
280 REM Om man endast har 16K minne
290 REM och flexskiva ansluten b|r
300 REM man st{nga av flexskiveenheten
310 REM och l{sa in programmet fr}n
320 REM kassett. Annars r{cker inte
330 REM minnet till.
340 REM 
350 DIM P(7,5),F(10),Z(2)
360 DIM F4$(4,4)=7,X$=1,A$=1,I$=10,H$=8,C1$=5,C2$=5,C3$=5
362 C1$=GYEL
363 C2$=CYA
364 C3$=GRED
370 REM 
380 REM +-------------+
390 REM ! Huvudslinga !
400 REM +-------------+
410 GOSUB 560 : REM Initiering
420 GOSUB 2770 : REM Hj{lptext
430 T1=PEEK(-14) : T2=PEEK(-13) : T3=PEEK(-12) ! Tiden
435 IF T1<0 OR T1>23 OR T2<0 OR T2>59 OR T3<0 OR T3>59 THEN POKE -14,0,0,0 : GOTO 430
440 GOSUB 740 : REM Rita alla klossar
450 IF S=0 GOSUB 1160 : REM Input kommando
460 IF S=1 GOSUB 1240 : REM Automatiska drag
470 IF X$='B' GOTO 410 ! OUT 6,0 : GOTO ...
480 GOSUB 1800 : REM Utf|r kommando
490 IF D ; CUR(1,0) C2$ CUR(1,0) ' Nu {r Mintman ute ur l}dan ' ! OUT 6,7:;CUR...
500 IF D=0 ; CUR(1,0) TAB(39) ! OUT 6,0:;CUR...
510 GOTO 450
520 REM 
530 REM +------------+
540 REM ! Initiering !
550 REM +------------+
560 ; CHR$(12) : RESTORE 620
570 FOR R=1 TO 5 : FOR K=1 TO 4 : READ P(R,K) : NEXT K : NEXT R 
580 FOR I=1 TO 10 : READ F(I) : NEXT I 
590 FOR I=1 TO 4 : FOR J=1 TO 4 : READ F4$(I,J) : NEXT J : NEXT I 
600 X=1 : Y=1 : D=0 : D1=0 : RETURN 
610 REM Klossarnas utg}ngsl{ge
620 DATA 1,4,4,8,1,4,4,8,2,5,5,9,2,6,7,9,3,0,0,10
630 REM Typ av klossar
640 REM 1 = st}ende kloss   3 = liten kloss
650 REM 2 = liggande kloss  4 = stor kloss
660 DATA 1,1,3,4,2,3,3,1,1,3
670 REM Utseende klosstyp 4, stor kloss
680 DATA 'y,,',5n9j?,'+||? ',' b+/','=,l{',({$,*}|~?k,'?/c j'
690 DATA 5jjhhhh,2jjjjj,t*jjj,}trr,'hhhjj ','jjjj"z',jj*`~,rp|
700 REM 
710 REM +-------------------+
720 REM ! Rita alla klossar !
730 REM +-------------------+
740 I$='MINTMAN ' : ; CHR$(12) I$ I$ I$ I$
750 ; CUR(2,0) C1$ CUR(2,1) '`' : FOR I=3 TO 22 : ; CUR(I,0) C1$ CUR(I,1) 'j';
760 NEXT I : ; CUR(2,2) STRING$(28,112);
770 FOR K=1 TO 4 : FOR R=1 TO 5 : GOSUB 830 : REM Rita en kloss
780 NEXT R : NEXT K : RETURN 
790 REM 
800 REM +---------------------+
810 REM ! Rita en kloss (r,k) !
820 REM +---------------------+
830 T=F(P(R,K)) : IF T GOSUB 2480 : GOTO 860
840 I=0 : IF R=5 OR F(P(R+1,K))>0 LET I=1
850 IF K=4 OR F(P(R,K+1))>0 LET I=I+2
860 ; CUR(2,0) C1$;
865 FOR J=1 TO 4 : ; CUR((R-1)*4+J+2,(K-1)*7+2);
870   L=(I-1)*4+J : ON T+1 GOTO 890,950,990,1050,1100
880   REM Rita tom ruta
890   IF I=0 ; '       ';
900   IF I=1 IF J<4 ; '       '; ELSE ; 'ppppppp';
910   IF I=2 ; '      j';
920   IF I=3 IF J<4 ; '      j'; ELSE ; 'ppppppz';
930   GOTO 1110
940   REM Rita st}ende kloss
950   IF (L AND 1)>0 ; 'ffffffn'; : GOTO 1110
960   IF I=3 AND J=4 ; 'yyyyyy{'; ELSE ; '999999{';
970   GOTO 1110
980   REM Rita liggande kloss
990   IF L<=3 ; '8a&8a&8';
1000   IF L=4 ; 'xqvxqvx';
1010   IF L>=5 AND L<=7 ; 'a&8a&8k';
1020   IF L=8 ; 'qvxqvx{';
1030   GOTO 1110
1040   REM Rita liten kloss
1050   IF L=1 OR L=3 ; '((((((j';
1060   IF L=2 ; 'bbbbbbj';
1070   IF L=4 ; 'rrrrrrz';
1080   GOTO 1110
1090   REM Rita stor kloss
1100   ; F4$(I,J);
1110 NEXT J : RETURN 
1120 REM 
1130 REM +----------------+
1140 REM ! Input kommando !
1150 REM +----------------+
1160 GOSUB 1720 : REM Rita mus
1170 ; CUR(23,0) C2$ '(ange kommando, tryck p} en tangent)';
1180 IF SYS(5)<128 GOSUB 1600 : GOTO 1180
1190 WHILE SYS(5)>127 : GET X$ : WEND : X$=CHR$(ASCII(X$) AND 223) : RETURN 
1200 REM 
1210 REM +------------------+
1220 REM ! Automatiska drag !
1230 REM +------------------+
1240 RESTORE 1470
1250 READ A,A$ : IF A=0 LET S=0 : RETURN 
1260 FOR R3=1 TO 5 : FOR K3=1 TO 4 : IF P(R3,K3)<>A NEXT K3 : NEXT R3 : GOTO 1250
1270 R3=R3-X : K3=K3-Y
1280 REM Flytta mus till kloss att flytta
1290 IF K3>0 LET X$='S'
1300 IF K3<0 LET X$='A' : K3=-K3
1310 GOSUB 1720 : IF K3=0 AND R3>0 GOTO 1350
1320 FOR I=0 TO V*100 : I$=CHR$(INP(34) AND 223) : IF I$='B' LET X$=I$ : RETURN 
1330 NEXT I : IF K3=0 GOTO 1350
1340 GOSUB 1800 : K3=K3-1 : GOTO 1310
1350 IF R3>0 LET X$='Z'
1360 IF R3<0 LET X$='W' : R3=-R3
1370 GOSUB 1720
1380 FOR I=0 TO V*100 : I$=CHR$(INP(34) AND 223) : IF I$='B' LET X$=I$ : RETURN 
1390 NEXT I : IF R3=0 GOTO 1420
1400 GOSUB 1800 : R3=R3-1 : GOTO 1370
1410 REM Flytta kloss
1420 IF A$='U' LET X$='^'
1430 IF A$='N' LET X$=CHR$(13)
1440 IF A$='V' LET X$=CHR$(8)
1450 IF A$='H' LET X$=CHR$(9)
1460 GOSUB 1800 : GOSUB 1720 : GOTO 1250
1470 DATA 10,V,9,N,6,N,5,H,2,H,3,U,6,V,2,N,5,V,5,V,7,U,7,H,10,U,10,U
1480 DATA 2,H,3,H,3,N,5,N,10,V,10,V,7,V,7,V,2,U,9,U,3,H,3,H,6,H,6,H
1490 DATA 5,N,7,N,7,V,2,V,9,V,8,N,8,N,4,H,1,H,10,U,10,U,7,U,7,U,2,V,1,N
1500 DATA 1,N,4,V,8,U,8,U,9,H,6,U,6,U,3,V,3,U,5,H,5,H,1,N,2,N,6,V,6,V,4,N
1510 DATA 10,H,10,H,7,U,7,H,6,U,6,U,2,U,2,U,1,V,3,V,3,N,4,N,10,N,10,V
1520 DATA 8,V,9,U,9,U,4,H,10,N,10,N,2,H,1,U,1,U,10,V,10,N,1,N,2,N,6,N
1530 DATA 6,H,1,U,1,U,2,V,4,V,9,N,9,N,8,H,6,H,7,H,1,H,2,U,2,U,4,V,6,N,6,N,7,N
1540 DATA 7,N,8,V,9,U,9,U,7,H,6,U,5,U,3,H,3,H,10,H,10,H,4,N,6,V,6,V,7,V
1550 DATA 7,V,5,U,10,U,10,H,4,H,4,N,0,-
1560 REM 
1570 REM +------------+
1580 REM ! Visa tiden !
1590 REM +------------+
1600 WHILE PEEK(-11)>80 : WEND 
1610 FOR I=0 TO 2 : Z(I)=PEEK(-14+I) : NEXT I 
1620 Z(2)=Z(2)-T3 : IF Z(2)<0 THEN Z(1)=Z(1)-1 : Z(2)=60+Z(2)
1630 Z(1)=Z(1)-T2 : IF Z(1)<0 THEN Z(0)=Z(0)-1 : Z(1)=60+Z(1)
1640 Z(0)=Z(0)-T1 : IF Z(0)<0 THEN Z(1)=24+Z(0)
1650 H$='' : FOR I=0 TO 2 : I$=NUM$(Z(I)) : H$=H$+STRING$(2-LEN(I$),48)+I$
1660   IF I<2 LET H$=H$+'.'
1670 NEXT I : ; CUR(5,31) C2$ 'Tid:' CUR(7,31) C2$ H$ CUR(2,0) C1$; : RETURN 
1680 REM 
1690 REM +----------+
1700 REM ! Rita mus !
1710 REM +----------+
1720 J=(Y-1)*7+3 : ; CUR(1,0) C3$; : FOR I=(X-1)*4+4 TO I+1
1730 ; CUR(I,J) '  '; : NEXT I 
1740 IF NOT (S=1 AND V=0) GOSUB 1600 : REM Visa tid
1750 RETURN 
1760 REM 
1770 REM +----------------+
1780 REM ! Utf|r kommando !
1790 REM +----------------+
1800 R=X : K=Y : T=F(P(X,Y))
1810 I=INSTR(1,'WZASQ^'+CHR$(13,8,9,196,198),X$) : IF I=0 RETURN 
1815 IF I>9 THEN I=I-4
1820 IF I>5 IF T>0 GOTO 1930 ELSE RETURN 
1830 REM Flytta mus
1840 ON I GOTO 1850,1860,1870,1880,1890
1850 X=X+(X>1) : GOTO 1900 : REM Mus v{nster
1860 X=X-(X<5) : GOTO 1900 : REM Mus h|ger
1870 Y=Y+(Y>1) : GOTO 1900 : REM Mus v{nster
1880 Y=Y-(Y<4) : GOTO 1900 : REM Mus h|ger
1890 X=1 : Y=1 : REM Mus home
1900 IF X<>R OR Y<>K GOSUB 830 : REM Sl{ck mus
1910 RETURN 
1920 REM F|rflyttning av kloss
1930 X1=0 : Y1=0 : IF I=6 LET X1=-1 : REM Flytta Upp}t
1940 IF I=7 LET X1=1 : REM Flytta ned}t
1950 IF I=8 LET Y1=-1 : REM Flytta v{nster
1960 IF I=9 LET Y1=1 : REM Flytta h|ger
1970 GOSUB 2480 : ON T GOTO 1990,2090,2190,2250
1980 REM Flytta st}ende kloss
1990 IF X1=-1 AND R1=1 OR X1=1 AND R1=4 RETURN 
2000 IF Y1=-1 AND K1=1 OR Y1=1 AND K1=4 RETURN 
2010 IF X1=-1 AND P(R1-1,K1)>0 OR X1=1 AND P(R1+2,K1)>0 RETURN 
2020 IF Y1<>0 AND (P(R1,K1+Y1)>0 OR P(R1+1,K1+Y1)>0) RETURN 
2030 I=P(R1,K1) : P(R1,K1)=0 : P(R1+1,K1)=0
2040 R2=R1+X1 : K2=K1+Y1
2050 P(R2,K2)=I : P(R2+1,K2)=I : X=X+X1 : Y=Y+Y1
2060 R=R1 : K=K1 : GOSUB 830 : R=R+1 : GOSUB 830
2070 R=R2 : K=K2 : GOSUB 830 : R=R+1 : GOSUB 830 : GOTO 2400
2080 REM Flytta liggande kloss
2090 IF X1=-1 AND R1=1 OR X1=1 AND R1=5 RETURN 
2100 IF Y1=-1 AND K1=1 OR Y1=1 AND K1=3 RETURN 
2110 IF X1<>0 AND (P(R1+X1,K1)>0 OR P(R1+X1,K1+1)>0) RETURN 
2120 IF Y1=-1 AND P(R1,K1-1)>0 OR Y1=1 AND P(R1,K1+2)>0 RETURN 
2130 I=P(R1,K1) : P(R1,K1)=0 : P(R1,K1+1)=0
2140 R2=R1+X1 : K2=K1+Y1
2150 P(R2,K2)=I : P(R2,K2+1)=I : X=X+X1 : Y=Y+Y1
2160 R=R1 : K=K1 : GOSUB 830 : K=K+1 : GOSUB 830
2170 R=R2 : K=K2 : GOSUB 830 : K=K+1 : GOSUB 830 : GOTO 2400
2180 REM Flytta liten kloss
2190 IF X1=-1 AND R1=1 OR X1=1 AND R1=5 RETURN 
2200 IF Y1=-1 AND K1=1 OR Y1=1 AND K1=4 RETURN 
2210 IF F(P(R1+X1,K1+Y1))>0 RETURN 
2220 P(R1+X1,K1+Y1)=P(R1,K1) : P(R1,K1)=0 : X=X+X1 : Y=Y+Y1
2230 GOSUB 830 : R=X : K=Y : GOSUB 830 : GOTO 2400
2240 REM Flytta stor kloss
2250 IF D=0 AND X1=1 AND R1=4 AND K1=2 LET D=1 : GOTO 2330 : REM Mintman ute!
2260 IF X1=-1 AND R1=1 OR X1=1 AND R1=4 RETURN 
2270 IF Y1=-1 AND K1=1 OR Y1=1 AND K1=3 RETURN 
2280 IF X1=-1 AND (P(R1-1,K1)>0 OR P(R1-1,K1+1)>0) RETURN 
2290 IF X1=1 AND (P(R1+2,K1)>0 OR P(R1+2,K1+1)>0) RETURN 
2300 IF Y1=-1 AND (P(R1,K1-1)>0 OR P(R1+1,K1-1)>0) RETURN 
2310 IF Y1=1 AND (P(R1,K1+2)>0 OR P(R1+1,K1+2)>0) RETURN 
2320 IF D>0 IF X1=-1 LET D=0 ELSE RETURN 
2330 I=P(R1,K1) : P(R1,K1)=0 : P(R1,K1+1)=0
2340 P(R1+1,K1)=0 : P(R1+1,K1+1)=0
2350 R2=R1+X1 : K2=K1+Y1 : Y=Y+Y1 : IF X+X1<=5 LET X=X+X1
2360 P(R2,K2)=I : P(R2,K2+1)=I : P(R2+1,K2)=I : P(R2+1,K2+1)=I
2370 R=R2 : K=K2 : GOSUB 830 : K=K+1 : GOSUB 830
2380 IF D=0 LET R=R2+1 : K=K2 : GOSUB 830 : K=K+1 : GOSUB 830
2390 REM Rita alla tomma rutor
2400 FOR R=1 TO 5 : FOR K=1 TO 4 : IF P(R,K)=0 GOSUB 830
2410 NEXT K : NEXT R : D1=D1+1
2420 ; CUR(10,31) C2$ 'Antal' CUR(11,31) C2$ 'drag:';
2430 ; CUR(13,31) C2$ D1 : RETURN 
2440 REM 
2450 REM +----------------+
2460 REM ! Position kloss !
2470 REM +----------------+
2480 T=F(P(R,K)) : ON T GOSUB 2530,2620,2670,2690
2490 IF R=R1 LET I=1 ELSE I=3
2500 IF K<>K1 LET I=I+1
2510 RETURN 
2520 REM St}ende kloss
2530 K1=K : IF R=1 LET R1=1 : RETURN 
2540 IF R=5 LET R1=4 : RETURN 
2550 IF R=2 IF F(P(R-1,K))=T LET R1=1 : RETURN ELSE R1=2 : RETURN 
2560 IF R=4 IF F(P(R+1,K))=T LET R1=4 : RETURN ELSE R1=3 : RETURN 
2570 IF F(P(R-2,K))=T LET R1=3 : RETURN 
2580 IF F(P(R+2,K))=T LET R1=2 : RETURN 
2590 IF F(P(R-1,K))=T LET R1=2 : RETURN 
2600 R1=3 : RETURN 
2610 REM Liggande kloss
2620 R1=R : IF K=1 LET K1=1 : RETURN 
2630 IF K=4 LET K1=3 : RETURN 
2640 IF F(P(R,K-1))=T LET K1=K-1 ELSE K1=K
2650 RETURN 
2660 REM Liten kloss
2670 R1=R : K1=K : RETURN 
2680 REM Stor kloss
2690 IF R=1 LET R1=1
2700 IF F(P(R-1,K))=T LET R1=R-1 ELSE R1=R
2710 IF F(P(R,K-1))=T LET K1=K-1 ELSE K1=K
2720 RETURN 
2730 REM 
2740 REM +-----------+
2750 REM ! Hj{lptext !
2760 REM +-----------+
2770 FOR R=22 TO 0 STEP -1
2780   ; CUR(R+1,R+1) SPACE$(15) CUR(R,R) '** MINTMAN **'
2790 FOR K=0 TO 200 : NEXT K : NEXT R 
2800 ; C2$ CUR(10,0);
2810 ; 'Flugan denna sommar (1985) verkar att'
2820 ; 'bli den sk Mintmannen.' : ; 
2830 ; 'Det {r ett enmansspel som g}r ut p}'
2840 ; 'att flytta klossar i en l}da s} att'
2850 ; 'herr Mintman trillar ut genom ett h}l'
2860 ; 'i l}dans nedre {nde.' : ; 
2870 ; 'Detta program simulerar en Mintman p}'
2880 ; 'bildsk{rmen. Du kan sj{lv f|rs|ka l|sa'
2890 ; 'problemet eller l}ta datorn visa hur'
2900 ; 'en l|sning kan se ut.' : ; 
2910 ; '(Tryck p} en tangent)';
2920 GOSUB 3330
2930 ; 'Du har en "mus" till ditt f|rfogande.'
2940 ; 'Den kan du flytta p} spelplanen med'
2950 ; 'dessa kommandon:' : ; : ; 
2960 ; '  Q' TAB(17) 'W'
2970 ; '(home)' TAB(15) '(upp)'
2980 ; TAB(13) 'A' TAB(21) 'S'
2990 ; TAB(9) '(v{nster) (h|ger)'
3000 ; TAB(17) 'Z'
3010 ; TAB(15) '(ner)'
3020 GOSUB 3330
3030 ; 'Du kan flytta den kloss som musen'
3040 ; 'befinner sig p} med dessa kommandon:' : ; 
3050 ; '   ^    (upp)'
3060 ; ' return (ner)'
3070 ; '  <---  (v{nster)'
3080 ; '  --->  (h|ger)' : ; 
3090 ; 'Naturligtvis m}ste den position dit du'
3100 ; 'vill flytta en kloss vara tom.'
3110 GOSUB 3330
3120 ; 'Om du under spelets g}ng trycker p}'
3130 ; 'bokstaven B s} f}r du b|rja om.' : ; : ; 
3140 ; 'V{lj vad du vill g|ra:' : ; 
3150 ; '1   Spela sj{lv' : ; 
3160 ; '2   Datorn visar en l|sning'
3170 ; '    (l{mpligt om du inte fattar hur'
3180 ; '    man g}r till v{ga)' : ; 
3190 GOSUB 3330
3200 IF X$='1' LET S=0 : RETURN 
3210 IF X$<>'2' GOTO 3120
3220 ; 'Datorn kommer nu att visa ett f|rslag'
3230 ; 'p} en l|sning. V{lj hastighet p}'
3240 ; 'f|revisningen:' : ; : ; 
3250 ; '1   H|gsta fart (f|r de avancerade)' : ; 
3260 ; '2   En ganska m}ttlig hastighet' : ; 
3270 ; '3   L}ngsamt (bra om du fortfarande'
3280 ; '    inte fattar n}gonting)'
3290 GOSUB 3330
3300 S=1 : IF X$='1' LET V=0 : RETURN 
3310 IF X$='2' LET V=2 : RETURN 
3320 IF X$='3' LET V=5 : RETURN ELSE 3220
3330 WHILE SYS(8) : WEND 
3340 FOR R=0 TO 7 : ; CUR(R,22) C1$; : NEXT R 
3350 FOR K=1 TO 4
3360   ; CUR(K-1,23) F4$(1,K) F4$(2,K) CUR(K+3,23) F4$(3,K) F4$(4,K);
3370 NEXT K 
3380 FOR I=1 TO 1000 : IF SYS(8) GOTO 3490
3390 NEXT I 
3400 ; CUR(0,23) 'j/#333+o5';
3410 ; CUR(1,23) 'j?!4555554+5';
3420 ; CUR(2,23) 'j7055555555525';
3430 ; CUR(3,23) 'j 55%%%%%%%55 ';
3440 ; CUR(4,23) '  q|~|t1 ';
3450 ; CUR(5,23) '`~?/o4 ~//4';
3460 ; CUR(6,23) 'j(w$~5f=j5';
3470 ; CUR(7,23) 'jw-,n,,g5';
3480 FOR I=1 TO 1000 : IF SYS(8)=0 NEXT I : GOTO 3350
3490 FOR R=10 TO 22 : ; CUR(R,0) C2$ SPACE$(39); : NEXT R : ; CUR(10,0);
3500 WHILE SYS(5)>127 : GET X$ : WEND : RETURN 
