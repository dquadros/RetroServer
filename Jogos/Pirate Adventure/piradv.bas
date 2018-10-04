#!/usr/local/bin/yabasic
5 REM COPYRIGHT SCOTT ADAMS, 1978
10 REM Adaptado por D.Q 02/10/2018
20 CLEAR SCREEN 
25 PRINT REVERSE AT(36,12) "AGUARDE"
30 DIM NV(1),CA(151,7),NV$(59,1),IA$(60),IA(60),RS$(33),RM(33,5),MS$(71),NT$(1),I2(60)
40 Z$ = "I'VE TOO MUCH TO CARRY. TRY -TAKE INVENTORY-"
42 TAB12$ = "            "
44 GOSUB 1240 
46 CLEAR SCREEN 
48 GOTO 100
50 CLEAR SCREEN
51 PRINT TAB12$, "*** WELCOME TO ADVENTURE LAND. (#1.00) ***"
52 PRINT : PRINT
53 PRINT "UNLESS TOLD DIFFERENTLY YOU MUST FIND *TREASURES* AND RETURN THEM TO THEIR"
54 PRINT "PROPER PLACES !"
60 PRINT
61 PRINT "I'M YOU PUPPET. GIVE ME ENGLISH COMANDS THAT CONSIST OF A NOUM AND"
62 PRINT "VERB. SOME EXAMPLES ..." : PRINT
63 PRINT TAB12$, "TO FIND OUT WHAT YOU'RE CARRYING YOU MIGHT SAY: TAKE INVENTORY"
64 PRINT TAB12$, "TO GO INTO A HOLE YOU MIGHT SAY: GO HOLE"
65 PRINT TAB12$, "TO SAVE CURRENT GAME: SAVE GAME"
70 PRINT
80 PRINT "YOU WILL AT TIMES NEED SPECIAL ITEMS TO DO THINGS, BUT I'M SURE YOU"
81 PRINT "WILL BE A GOOD ADVENTURER AND FIGURE THESE THINGS OUT."
82 PRINT
90 PRINT: INPUT "HAPPY ADVENTURING... HIT ENTER TO START" K$
91 CLEAR SCREEN
92 RETURN
100 R=AR : LX=LT : DF=0 : SF=0 
102 INPUT "USE OLD 'SAVED' GAME? " K$ : K$=UPPER$(K$)
104 IF LEFT$(K$,1) <> "Y" THEN GOTO 130 ENDIF
110 INPUT "FILE NAME: " SV$ 
112 IF (NOT OPEN (#1,SV$,"r")) THEN PRINT "COULD NOT OPEN FILE!" : GOTO 102 : ENDIF
120 INPUT#1 SF,LX,DF,R 
122 FOR X=0 TO IL 
124 INPUT#1 IA(X)
126 NEXT
128 CLOSE #1
130 GOSUB 50 : GOSUB 240 : GOTO 160
140 PRINT : LINE INPUT "TELL ME WHAT TO DO: " TP$ : TP$=UPPER$(TP$) : PRINT 
142 GOSUB 170
144 IF F THEN PRINT "YOU USE WORD(S) I DON'T KNOW" : GOTO 140 : ENDIF
150 GOSUB 360
152 IF IA(9)=-1 THEN 
154 LX=LX-1
156 IF LX<0 THEN PRINT "LIGHT HAS RUN OUT" : IA(9)=0 ELSIF LX<25 THEN PRINT "LIGHT RUNS OUT IN ",LX,"TURNS!" : ENDIF
158 ENDIF
160 NV(0)=0 : GOSUB 360 : GOTO 140
170 K=0 : NT$(0)="" : NT$(1)="" 
180 FOR X=1 TO LEN(TP$)
182 K$=MID$(TP$,X,1)
184 IF K$=" " THEN K=1 ELSE NT$(K)=LEFT$(NT$(K)+K$,LN) : ENDIF
186 NEXT X
190 FOR X=0 TO 1
192 NV(X)=0
194 IF NT$(X)="" THEN GOTO 230 ENDIF
200 FOR Y=0 TO NL
202 K$=NV$(Y,X) 
204 IF LEFT$(K$,1)="*" THEN K$=MID$(K$,2) ENDIF
206 IF (X=1 AND Y<7) THEN K$=LEFT$(K$,LN) ENDIF
210 IF NT$(X)<>K$ THEN GOTO 220 ENDIF
212 NV(X)=Y
214 IF LEFT$(NV$(NV(X),X),1)="*" THEN NV(X)=NV(X)-1 : GOTO 214 : ENDIF
216 BREAK
220 NEXT Y
230 NEXT X
232 F=NV(0)<1 OR LEN(NT$(1)) > 0 AND NV(1)<1 
234 RETURN
240 IF (DF AND IA(9) <> -1 AND IA(9) <> R) THEN PRINT "I CAN'T SEE, ITS TOO DARK." : RETURN : ENDIF
250 K=-1 
255 IF LEFT$(RS$(R),1)="*" THEN PRINT MID$(RS$(R),2); ELSE PRINT "I'M IN A ",RS$(R); : ENDIF
260 FOR Z=0 TO IL 
270 IF K THEN IF IA(Z) = R THEN PRINT ". VISIBLE ITEMS HERE:" : K=0 : ENDIF : ENDIF
280 IF IA(Z) <> R THEN GOTO 300 ENDIF
290 GOSUB 340 : PRINT TP$,".  ";
300 NEXT Z
305 PRINT
310 K=-1
312 FOR Z=0 TO 5
314 IF K THEN IF RM(R,Z) <> 0 THEN PRINT : PRINT "OBVIOUS EXITS: "; : K=0 : ENDIF : ENDIF
320 IF RM(R,Z) <> 0 THEN PRINT NV$(Z+1,1)," "; : ENDIF
330 NEXT Z
332 PRINT : PRINT
334 RETURN
340 TP$ = IA$(Z) 
342 IF RIGHT$(TP$,1)<>"/" THEN RETURN : ENDIF
344 FOR W=LEN(TP$)-1 TO 1 STEP -1
346 IF MID$(TP$,W,1)="/" THEN TP$=LEFT$(TP$,W-1) : BREAK : ENDIF
348 NEXT W
350 RETURN
360 F2=-1 : F=-1 : F3=0 
362 IF NV(0)=1 AND NV(1)<7 THEN GOTO 610 ENDIF
364 X=0
366 V=INT(CA(X,0)/150)
368 IF NV(0)=0 THEN IF V<>0 THEN RETURN : ENDIF : ENDIF
370 IF NV(0) <> V THEN GOTO 980 ELSE N=INT(CA(X,0)-V*150) ENDIF
380 IF NV(0)=0 THEN F=0 : IF RAN(100) <= N THEN GOTO 400 ELSE GOTO 980 ENDIF : ENDIF
390 IF N<>NV(1) AND N<>0 THEN GOTO 980 ENDIF
400 F2=-1 : F=0 : F3=-1
402 Y=1
404 W=CA(X,Y) : LL=INT(W/20) : K=W-LL*20 : F1=-1 : 
406 ON K+1 GOTO 550,430,450,470,490,500,510,520,530,540,410,420,440,460,480
410 F1=0
412 FOR Z=0 TO IL
414 IF IA(Z)=-1 THEN F1 = -1 : BREAK : ENDIF
416 NEXT Z
418 GOTO 550
420 F1=-1
422 FOR Z=0 TO IL
424 IF IA(Z)=-1 THEN F1 = 0 : BREAK : ENDIF
426 NEXT Z
428 GOTO 550
430 F1=IA(LL)=-1 : GOTO 550
440 F1=IA(LL)<>-1 AND IA(LL)<>R : GOTO 550
450 F1=IA(LL)=R : GOTO 550
460 F1=IA(LL)<>0 : GOTO 550
470 F1=IA(LL)=R OR IA(LL)=-1 : GOTO 550
480 F1=IA(LL)=0 : GOTO 550
490 F1=R=LL : GOTO 550
500 F1=IA(LL)<>R : GOTO 550
510 F1=IA(LL)<>-1: GOTO 550
520 F1=R<>LL : GOTO 550
530 F1=AND(SF, 2^LL) : F1=F1<>0 : GOTO 550
540 F1=AND(SF, 2^LL) : F1=F1=0 : GOTO 550
550 F2 = F2 AND F1
552 IF NOT F2 THEN GOTO 980 ENDIF
554 Y=Y+1 : IF Y<=5 THEN GOTO 404 ENDIF
560 IP=0
562 Y=1
564 K=INT((Y-1)/2+6)
566 ON Y GOTO 570,580,570,580
570 AC=INT(CA(X,K)/150) : GOTO 590
580 AC=MOD(CA(X,K),150)
590 IF AC>101 THEN GOTO 600 ENDIF
592 IF AC=0 THEN GOTO 960 ENDIF
594 IF AC<52 THEN PRINT MS$(AC) : GOTO 960 ENDIF
596 ON AC-51 GOTO 660,700,740,760,770,780,790,760,810,830,840,850,860,870,890,920,930,940,950,710,750
600 PRINT MS$(AC-50) : GOTO 960
610 L=DF : IF L THEN L=(DF AND IA(9)<>R AND IA(9)<>-1) : IF L THEN PRINT "DANGEROUS TO MOVE IN THE DARK !" : ENDIF : ENDIF
620 IF NV(1)<1 THEN PRINT "GIVE ME A DIRECTION TOO." : GOTO 1040 : ENDIF
630 K=RM(R,NV(1)-1) : IF K<1 THEN IF L THEN PRINT "I FELL DOWN AND BROKE MY NECK." : K=RL : DF=0 : ELSE PRINT "I CAN'T GO IN THAT DIRECTION" : GOTO 1040 : ENDIF : ENDIF
640 IF NOT L THEN CLEAR SCREEN ENDIF
650 R=K : GOSUB 240 : GOTO 1040
660 L=0
662 FOR Z=1 TO IL
664 IF IA(Z)=-1 THEN L=L+1 ENDIF
670 NEXT Z
680 IF L>=MX THEN PRINT Z$ : GOTO 970 : ENDIF
690 GOSUB 1050 : IA(P)=-1 : GOTO 960
700 GOSUB 1050 : IA(P)=R : GOTO 960
710 PRINT "SAVING GAME" : INPUT "NAME OF FILE: " SV$ : 
712 IF (NOT OPEN(#1,SV$,"w")) THEN PRINT "COULD NOT CREATE FILE" : GOTO 960 : ENDIF
720 PRINT#1 SF,LX,DF,R : FOR W=0 TO IL : PRINT#1 IA(W) : NEXT W : CLOSE #1
730 GOTO 960
740 GOSUB 1050 : R=P : GOTO 960
750 GOSUB 1050 : L=P : GOSUB 1050 : Z=IA(P) : IA(P)=IA(L) : IA(L)=Z : GOTO 960
760 GOSUB 1050 : IA(P)=0 : GOTO 960
770 DF=-1 : GOTO 960
780 DF=0 : GOTO 960
790 GOSUB 1050
800 SF=OR(SF,2^P) : GOTO 960
810 GOSUB 1050
820 MASK=2^P : IF AND(SF,MASK)<>0 THEN SF=XOR(SF,MASK) ENDIF : GOTO 960
830 PRINT "I'M DEAD..." : R=RL : DF=0 : GOTO 860
840 GOSUB 1050 : L=P : GOSUB 1050 : IA(L)=P : GOTO 960
850 PRINT "THE GAME IS NOW OVER."
852 INPUT "ANOTHER GAME? "K$ : K$=UPPER$(K$)
854 IF LEFT$(K$,1)="N" THEN END ELSE FOR K=0 TO IL : IA(K)=I2(K) : NEXT : GOTO 100 : ENDIF
860 GOSUB 240 : GOTO 960
870 L=0
872 FOR Z=1 TO IL 
874 IF IA(Z)=TR AND LEFT$(IA$(Z),1)="*" THEN L=L+1 ENDIF
876 NEXT Z
880 PRINT "I'VE STORED ",L," TREASURES." : PRINT "ON A SCALE OF 0 TO 100 THAT RATES A ",INT(L/TT*100)
885 IF L=TT THEN PRINT "WELL DONE." : GOTO 850 ELSE GOTO 960 : ENDIF
890 PRINT "I'M CARRYING: " : K$="NOTHING" : POS = 0
892 FOR Z=0 TO IL
894 IF IA(Z)<>-1 THEN GOTO 910 ELSE GOSUB 340 : IF LEN(TP$)+POS+2 > 79 THEN PRINT : POS = 0 :  ENDIF : ENDIF
900 PRINT TP$,". " : POS = POS+LEN(TP$)+2 : K$=""
910 NEXT Z
912 PRINT K$ : GOTO 960
920 P=0 : GOTO 800
930 P=0 : GOTO 820
940 LX=LT : IA(9)=-1 : GOTO 960
950 CLEAR SCREEN : GOTO 960
960 Y=Y+1 : IF Y<=4 THEN GOTO 564 ENDIF
970 IF NV(0) <> 0 THEN GOTO 990 ENDIF
980 X=X+1 : IF X<=CL THEN GOTO 366 ENDIF
990 REM
1000 IF NV(0)=0 THEN GOTO 1040 ENDIF
1010 GOSUB 1060
1020 IF F THEN PRINT "I DON'T UNDERSTAND YOUR COMAND" : GOTO 1040 : ENDIF
1030 IF NOT F2 THEN PRINT "I CAN'T DO THAT YET" : GOTO 1040 : ENDIF
1040 RETURN
1050 IP=IP+1 : W=CA(X,IP) : P=INT(W/20) : M=W-P*20 : IF M<>0 THEN GOTO 1050 ELSE RETURN ENDIF
1060 IF NV(0) <> 10 AND NV(0) <> 18 OR F3 THEN GOTO 1230 ENDIF
1070 IF NV(1)=0 THEN PRINT "WHAT?" : GOTO 1180 : ENDIF
1080 IF NV(0) <> 10 THEN GOTO 1110 ENDIF
1090 L=0 
1192 FOR Z=0 TO IL 
1194 IF IA(Z)=-1 THEN L=L+1 ENDIF
1100 NEXT Z
1102 IF L>=MX THEN PRINT Z$ : GOTO 1180 : ENDIF
1110 K=0
1112 FOR X=0 TO IL
1114 IF RIGHT$(IA$(X),1)<>"/" THEN GOTO 1190 ELSE LL=LEN(IA$(X))-1 : TP$=MID$(IA$(X),1,LL) : ENDIF
1116 FOR Y=LL TO 2 STEP -1 : IF MID$(TP$,Y,1)<>"/" THEN GOTO 1185 : ENDIF
1120 TP$=LEFT$(MID$(TP$,Y+1),LN)
1130 IF TP$<>NV$(NV(1),1) THEN BREAK ENDIF
1140 IF NV(0)=10 THEN GOTO 1160 ENDIF
1150 IF IA(X)<>-1 THEN K=1 : BREAK ELSE IA(X)=R : K=3 : GOTO 1170 : ENDIF
1160 IF IA(X)<>R THEN K=2 : BREAK ELSE IA(X)=-1 : K=3 : ENDIF
1170 PRINT "OK, ";
1180 F=0 : RETURN
1185 NEXT Y
1190 NEXT X
1200 IF K=1 THEN PRINT "I'M NOT CARRYING IT" ELSIF K=2 THEN PRINT "I DON'T SEE IT HERE" ENDIF
1210 IF K=0 AND NOT F3 THEN PRINT "IT'S BEYOND MY POWER TO DO THAT" : F=0 : ENDIF
1220 IF K<>0 THEN F=0 ENDIF
1230 RETURN
1240 RESTORE
1250 READ IL,CL,NL,RL,MX,AR,TT,LN,LT,ML,TR
1280 FOR X=0 TO CL : READ CA(X,0),CA(X,1),CA(X,2),CA(X,3),CA(X,4),CA(X,5),CA(X,6),CA(X,7):NEXT
1290 FOR X=0 TO NL : READ NV$(X,0),NV$(X,1) : NEXT
1300 FOR X=0 TO RL : READ RM(X,0),RM(X,1),RM(X,2),RM(X,3),RM(X,4),RM(X,5),RS$(X) : NEXT
1310 FOR X = 0 TO ML : READ MS$(X) : NEXT
1320 FOR X = 0 TO IL : READ IA$(X),IA(X) : I2(X) = IA(X) : NEXT
1330 RETURN
2000 DATA 60,151,59,33,5,1,2,3,200,71,1
2010 DATA 80,422,342,420,340,0,16559,8850,80,462,482,460,0,0,15712,1705,100,521,552,540,229,220,203,8700,3,483,0,0,0,0,15712,0,100,284,0,0,0,0,8550,0,100,28,663,403,40,0,8700,0,100,48,20,660,740,220
2020 DATA 9055,10902,100,28,20,0,0,0,3810,0,100,8,700,720,0,0,10868,0,100,48,40,640,400,300,9055,8305,25,664,0,0,0,0,4263,0,40,104,886,0,0,0,4411,0,80,242,502,820,80,240,9321,10109,100,8,140,80,500,0,10262,8850,35,421,846,420,200,0,5162,0
2030 DATA 100,129,120,0,0,0,6508,0,50,242,982,820,440,240,9321,8850,35,483,69,0,0,0,15705,0,10,483,249,0,0,0,15706,0,50,484,1073,1086,0,0,17661,9150,50,204,1086,0,0,0,16711,0,10,209,1040,1060,300,1100,10872,10050,10,208,1040,1060,89,0,10867
2040 DATA 0,85,483,8,0,0,0,15719,10200,100,8,0,0,0,0,10200,0,100,104,0,0,0,0,8550,0,80,462,282,280,1160,0,1422,0,158,82,60,0,0,0,8170,9600,4510,61,0,0,0,0,300,0,163,22,100,0,0,0,8170,9600,8100,0,0,0,0,0,16200,0,4800,104,120,61,0,0,10507
2050 DATA 8164,4800,107,100,61,89,0,10507,8164,4063,22,0,0,0,0,647,0,5570,161,203,160,180,0,10870,1264,6170,181,180,160,0,0,8302,0,6300,104,0,0,0,0,900,0,1529,442,465,440,0,0,7800,0,1529,442,462,0,0,0,760,9150,183,322,180,0,0,0,8170,9600
2060 DATA 1538,262,242,0,0,0,1800,0,1538,262,245,260,0,0,7800,0,5888,262,242,0,0,0,1800,0,5888,262,245,0,0,0,1950,0,6188,262,245,541,260,560,2155,7950,5888,261,0,0,0,0,2400,0,4088,561,0,0,0,0,2400,0,4088,263,0,0,0,0,2713,0,4088,562,580,109
2070 DATA 100,249,2303,8700,4088,249,562,108,900,240,6203,8700,4088,248,562,0,0,0,6600,0,4068,103,69,0,0,0,646,0,4068,103,68,0,0,0,6600,0,5887,342,0,0,0,0,2550,0,5887,362,0,0,0,0,2713,0,5887,382,0,0,0,0,2100,0,159,382,320,0,0,0,8170,9600
2080 DATA 6187,342,362,0,0,0,2550,0,6187,345,362,541,360,380,8303,10050,3461,503,0,0,0,0,172,0,3750,0,0,0,0,0,9900,0,1528,0,0,0,0,0,9900,0,4108,1143,1012,0,0,0,646,0,6450,0,0,0,0,0,2853,0,4510,66,0,0,0,0,2720,0,4950,0,0,0,0,0,9750,0,5114,0
2090 DATA 0,0,0,0,10650,0,7092,592,0,0,0,0,2745,0,185,284,140,0,0,0,8156,10564,4098,1054,0,0,0,0,647,17550,4098,1053,0,0,0,0,647,17400,4083,322,0,0,0,0,647,0,4095,762,0,0,0,0,647,0,195,782,921,0,0,0,2727,0,195,762,261,0,0,0,2727,0,6900,0,0
2100 DATA 0,0,0,9450,0,1526,602,0,0,0,0,2723,0,1541,621,602,640,520,600,7853,8250,195,782,661,0,0,0,2727,0,7092,623,583,303,643,20,8700,0,7092,0,0,0,0,0,3750,0,200,722,220,0,0,0,10554,9600,195,762,61,0,0,0,2727,0,4050,0,0,0,0,0,10564,0,1526
2110 DATA 523,520,0,0,0,7800,0,195,762,340,0,0,0,8126,8464,195,782,360,0,0,0,8157,10564,7530,404,242,1053,89,0,17250,0,4800,0,0,0,0,0,450,0,5868,103,200,69,60,0,4553,8700,5868,68,0,0,0,0,494,0,1546,146,0,0,0,0,4800,0,1546,802,141,140,840,0
2120 DATA 8302,0,2746,841,840,140,0,0,8302,4950,3496,802,0,0,0,0,811,0,3496,841,840,140,0,0,811,8302,7366,822,820,240,400,0,5305,9300,5861,503,0,0,0,0,2100,0,8411,501,500,140,0,0,5459,7833,192,742,400,0,0,0,8170,9600,201,404,88,420,240,242
2130 DATA 8170,8071,201,404,89,120,0,0,8170,9600,7530,404,245,0,0,0,2737,0,7530,404,912,0,0,0,2738,0,7530,404,89,80,740,420,5908,9300,7530,404,88,80,740,120,5910,9300,7671,0,0,0,0,0,6000,0,4553,903,0,0,0,0,6300,0,1350,0,0,0,0,0,6000,0,1510
2140 DATA 62,60,0,0,0,7800,0,5860,63,0,0,0,0,18000,0,201,404,88,420,0,0,8170,9600,186,284,360,0,0,0,8170,9600,1539,482,242,0,0,0,1800,0,1539,482,480,0,0,0,7904,16800,194,682,300,0,0,0,8170,9600,174,149,464,140,0,0,8751,0,174,160,0,0,0,0
2150 DATA 8751,0,7800,444,940,921,952,0,10548,8014,7800,124,921,0,0,0,7350,0,7800,424,992,980,921,0,10553,7264,8250,104,0,0,0,0,10505,9600,7800,464,148,1140,921,1152,10553,7264,1541,643,640,0,0,0,7800,0,163,104,40,0,0,0,8170,9600,6300,44,0
2160 DATA 0,0,0,15450,0,4534,583,0,0,0,0,4650,0,6187,702,541,0,0,0,2713,16050,5887,702,0,0,0,0,2713,0,5887,0,722,0,0,0,2100,0,198,1022,480,0,0,0,8170,9600,157,2,24,40,0,0,8170,9600,1510,44,60,40,80,85,7801,10800,1532,302,208,300,0,0,7800,0
2170 DATA 1532,302,209,0,0,0,2813,0,1532,305,0,0,0,0,10518,7564,8411,841,840,140,0,0,8922,0,165,1122,500,0,0,0,8170,9600,1392,0,0,0,0,0,6000,0,6300,284,0,0,0,0,16350,0,8582,0,0,0,0,0,17700,0,7800,921,209,302,200,0,8700,0,7950,0,0,0,0,0,2700
2180 DATA 0,5908,621,1143,1000,0,0,4553,0,5266,0,0,0,0,0,1800,0,6300,224,0,0,0,0,17517,17850,1200,0,0,0,0,0,17100,0,6300,124,0,0,0,0,16350,0,4350,208,1040,1060,0,0,10919,0,6300,184,242,0,0,0,3600,0,7800,921,160,140,0,0,7410,9000,6300,0,0,0
2190 DATA 0,0,0450,0
2200 DATA "AUT","ANY","GO","NORTH","*CLI","SOUTH","*WAL","EAST","*RUN","WEST","*ENT","UP","*PAC","DOWN","*FOL","STA","SAY","PAS","SAI","HAL","GET","BOO","*TAK","BOT","*CAT","*RUM","*PIC","WIN","*REM","GAM","*WEA","MON","*PUL","PIR","FLY","ARO","DRO","BAG","*REL","*DUF","*THR","TOR","*LEA","OFF","*GIV","MAT","DRI","YOH","*EAT"
2210 DATA "30","INV","LUM","SAI","RUG","LOO","KEY","*SHO","INV","WAI","DUB","REA","SAI",".","FIS","YOH","ANC","SCO","SHA","SAV","PLA","KIL","CAV","*ATT","PAT","LIG","DOO",".","CHE","OPE","PAR","*SMA","HAM","UNL","NAI","HEL","BOA","AWA","*SHI","*BUN","SHE","","CRA","QUI","WAT","BUI","*SAL","*MAK","LAG","WAK","*TID","SET","PIT","CAS","SHO","DIG","*BEA"
2220 DATA "BUR","MAP","FIN","PAC","JUM","BON","EMP","HOL","WEI","SAN","","BOX","","SNE"
2230 DATA 0,0,0,0,0,0,"",0,0,0,0,0,0,"APARTMENT IN LONDON",0,0,0,0,0,1,"ALCOVE",0,0,4,2,0,0,"SECRET PASSAGEWAY",0,0,0,3,0,0,"MUSTY ATTIC",0,0,0,0,0,0
2240 DATA "*I'M OUTSIDE AN OPEN WINDOW ON A LEDGE ON THE SIDE OF A VERY TALL BUILDING",0,0,8,0,0,0,"SANDY BEACH ON A TROPICAL ISLE",0,12,13,14,0,11,"MAZE OF CAVES",0,0,14,6,0,0,"MEADOW",0,0,0,8,0,0,"GRASS SHACK",10,24,10,10,0,0,"*I'M IN THE OCEAN",0,0
2250 DATA 0,0,7,0,"PIT",7,0,14,13,0,0,"MAZE OF CAVES",7,14,12,19,0,0,"MAZE OF CAVES",0,0,0,8,0,0,"*I'M AT THE FOOT OF A CAVE RIDDEN HILL. A PATH LEADS TO THE TOP",17,0,0,0,0,0,"TOOL SHED",0,0,17,0,0,0,"LONG HALLWAY",0,0,0,16,0,0,"LARGE CAVERN",0,0,0,0,0
2260 DATA 14,"*I'M ON THE TOP OF A HILL. BELOW IS PIRATES ISLAND. ACROSS THE SEA OFF IN THE DISTANCE I SEE *TREASURE* ISLAND",0,14,14,13,0,0,"MAZE OF CAVES",0,0,0,0,0,0,"*I'M ABOARD PIRATE SHIP ANCHORED OFF SHORE",0,22,0,0,0,0
2270 DATA "*I'M ON THE BEACH AT TREASURE ISLAND",21,0,23,0,0,0,"SPOOKY OLD GRAVEYARD FILLED WITH PILES OF EMPTY AND BROKEN RUM BOTTLES",0,0,0,22,0,0,"LARGE BARREN FIELD",10,6,6,6,0,0,"SHALLOW LAGOON. TO THE NORTH IS THE OCEAN",0,0,0,23,0,0
2280 DATA "SACKED AND DESERTED MONASTARY",0,0,0,0,0,0,"",0,0,0,0,0,0,"",0,0,0,0,0,0,"",0,0,0,0,0,0,"",0,0,0,0,0,0,"",0,0,0,0,0,0,"",0,0,0,0,0,0,".",0,0,0,0,0,0,"*WELCOME TO NEVER NEVER LAND"
2300 DATA "","THERE'S A STRANGE SOUND","THE NAME OF THE BOOK IS -TREASURE ISLAND- THERE'S A WORD ENGRAVED IN THE FLYLEAF -YOHO- AND A MESSAGE - LONG JOHN SILVER LEFT 2 TREASURES ON TREASURE ISLAND!-","NOTHING HAPPENS"
2305 DATA "THERE'S SOMETHING THERE ALRIGHT. MAYBE I SHOULD"
2310 DATA "THAT'S NOT VERY SAFE","YOU MAY NEED MAGIC HERE","EVERYTHING SPINS AROUND AND SUDDENLY YOU ARE ELSEWHERE...","TORCH IS LIT","I WAS WRONG. I GUESS ITS NOT A MONGOOSE CAUSE THE SNAKES BIT IT.","I'M SNAKE BIT"
2320 DATA "PARROT ATTACKS SNAKES AND DRIVES THEN OFF","PIRATE WON'T LET ME","ITS LOCKED","ITS OPEN","THERE ARE A SET OF PLANS IN IT","NOT WHILE I'M CARRYING IT","CROCS STOP ME","SORRY I CAN'T","WRONG GAME YOU SILLY GOOSE!","I DON'T HAVE IT"
2330 DATA "PIRATE GRABS RUM AND SCUTTLES OFF CHORTLING","...I THINK ITS ME. HEE HEE.","ITS NAILED TO THE FLOOR!","-MAGIC WORD- HO AND A ...     (WORK ON IT. YOU'LL GET IT)","NO. SOMETHING IS MISSING!","IT WAS A TIGHT SQUEEZE!","SOMETHING WON'T FIT"
2340 DATA "SINCE NOTHING IS HAPPENING","I SLIPPED AND FELL...","SOMETHING FALLS OUT","THEY'RE PLANS TO BUIL JOLLY ROGER (A PIRATE SHIP!). YOU'LL NEED HAMMER NAILS LUMBER ANCHOR SAILS AND KEEL.","I'VE NO COINTAINER","IT SOAKS INTO THE GROUND"
6390 DATA "TOO DRY. FISH VANISH.","PIRATE AWAKENS. SAYS -AYE MATEY WE BE CASTING OFF SOON- HE THEN VANISHES","WHAT A WASTE...","I'VE NO CREW","PIRATE SAYS -AYE MATEY WE BE NEEDING A MAP FIRST-"
6400 DATA "AFTER A MONTH AT SEA WE SET ANCHOR OFF OF A SANDY BEACH. ALL ASHORE WHO'S GOING ASHORE...","TRY -WEIGH ANCHOR-","THERE'S A MAP IN IT","ITS A MAP TO TREASURE ISLAND. AT BOTTOM IT SAYS -30 PACES AND THEN DIG!-"
6410 DATA "*WELCOME TO -PIRATES ADVENTURE- BY SCOTT & ALEXIS ADAMS*                         (ADAPTADO POR D.Q.)","ITS EMPTY","I'VE NO PLANS!","OPEN IT?","GO THERE?","I FOUND SOMETHING!","I DIDNT FIND ANYTHING","I DON'T SEE IT HERE","OK I WALKED OFF 30 PACES."
6420 DATA "CONGRATULATIONS !!!   BUT YOU ADVENTURE IS NOT OVER YET ...","READING EXPANDS THE MIND","THE PARROT CRIES","-CHECK THE BAG MATEY-","-CHECK THE CHEST MATEY-","FROM THE OTHER SIDE!","OPEN THE BOOK!","THERE'S MULTIPLE EXITS HERE!"
6430 DATA "CROCS EAT FISH AND LEAVE","I'M UNDERWATER. I CAN'T SWIN. BLUB BLUB...","-PIECES OF EIGHT-","ITS STUCK IN THE SAND","USE 1 WORD","PIRATE SAYS -AYE MATEY WE BE WAITING FOR THE TIDE TO COME IN-","THE TIDE IS OUT","THE TIDE IN COMING IN"
6440 DATA "ABOUT 20 POUNDS. TRY -SET SAIL-","-TIDES A CHANGING MATEY-","NOTE HERE -I BE LIKING PARROTS. THEY BE SMART MATEY-","PIRATE FOLLOWS YOU ASHORE AS IF HE IS WAITING FOR SOMETHING."
6242 DATA "FLIGHT OF STAIRS",1,"OPEN WINDOW",2,"BOOKS IN A BOOKCASE",2
6450 DATA "LARGE LEATHER BOUND BOOK/BOO/",0,"BOOKCASE WITH A SECRET PASSAGE BEHIND IT",0,"PIRATE'S DUFFEL BAG/BAG/",4,"SIGN ON WALL -RETURN TREASURES HERE. SAY SCORE-",1,"EMPTY BOTTLE/BOT/",0
6460 DATA "UNLIT TORCH/TOR/",4,"LIT TORCH/TOR/",0,"MATCHES/MAT/",0,"SMALL SHIP'S KEEL AND MAST",6,"WICKED LOOKING PIRATE",9,"TREASURE CHEST/CHE/",9,"MONGOOSE/MON/",8,"RUSTY ANCHOR/ANC/",24,"GRASS SHACK",8,"MEAN AND HUNGRY LOOKING CROCODILES",11,"LOCKED DOOR",11
6470 DATA "OPEN DOOR WITH HALL BEYOUND",0,"PILE OF SAILS/SAI/",17,"FISH/FIS/",10,"*DUBLEONS*/DUB/",25,"DEADLY MAMBA SNAKES/SNA",25,"PARROT/PAR/",9,"BOTTLE OF RUM/BOT/",1,"RUG/RUG/",0,"RING OF KEYS/KEY/",0,"OPEN TREASURE CHEST/CHE/",0,"SET OF PLANS/PLA/",0,"RUG",1
6480 DATA "CLAW HAMMER/HAM/",15,"NAILS/NAI/",0,"PILE OF PRECUT LUMBER/LUM/",17,"TOOL SHED",17,"LOCKED DOOR",16,"OPEN DOOR WITH PIT BEYOND",0,"PIRATE SHIP",0,"ROCK WALL WITH NARROW CRACK IN IT",18,"NARROW CRACK IN ROCK",17,"SALT WATER",10,"SLEEPING PIRATE",0
6490 DATA "BOTTLE OF SALT WATER/BOT/",0,"PIECES OF BROKEN RUM BOTTLES",4,"NON-SKID SNEAKES/SNE/",1,"MAP/MAP/",0,"SHOVEL/SHO/",15,"MOULDLY OLD BONES/BON/",0,"SAND/SAN/",6,"BOTTLE OF RUM/BOT/",0,"*RARE OLD PRICELESS STAMPS*/STA/",0,"LAGOON",6,"THE TIDE IS OUT",24
6500 DATA "THE TIDE IS COMING IN",0,"WATER WINGS/WIN/",15,"FLOTSAM AND JETSAM",0,"MONASTARY",23,"PLAIN WOODEN BOX/BOX/",0,"DEAD SQUIRREL",0,"",0,"",0,""
