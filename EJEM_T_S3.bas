'****************************************************************
'*  Name    : UNTITLED.BAS                                      *
'*  Author  : [select VIEW...EDITOR OPTIONS]                    *
'*  Notice  : Copyright (c) 2020 [select VIEW...EDITOR OPTIONS] *
'*          : All Rights Reserved                               *
'*  Date    : 16/05/2020                                        *
'*  Version : 1.0                                               *
'*  Notes   :                                                   *
'*          :                                                   *
'****************************************************************
;-------------------------------------------------------------------------------
;**** Added by Fuse Configurator ****
; Use the Fuse Configurator plug-in to change these settings

Device = 16F886

Config1 FOSC_HS, WDTE_OFF, PWRTE_OFF, MCLRE_OFF, CP_OFF, CPD_OFF, BOREN_OFF, IESO_OFF, FCMEN_OFF, LVP_OFF, DEBUG_OFF
Config2 BOR4V_BOR40V, WRT_OFF

;**** End of Fuse Configurator Settings ****
;-------------------------------------------------------------------------------
Declare Xtal 20
;-------------------------------------------------------------------------------
Symbol CL=PORTA.0
Symbol DS=PORTA.1
Symbol ST=PORTA.2
;-------------------------------------------------------------------------------
Dim M[14] As Byte
Dim P[4] As Byte
Dim D[4] As Byte
Dim TM As Byte
Dim ND As Byte
Dim I As Byte
Dim J As Byte
Dim T As Byte
Dim AUX As Byte
;-------------------------------------------------------------------------------
TRISA=0 : TRISB=0 : ANSEL=0 : ANSELH=0

M[0]=$3E : M[1]=$73 : M[2]=$77 : M[3]=$3F : M[4]=$40
M[5]=$79 : M[6]=$38 : M[7]=$79 : M[8]=$39 : M[9]=$40
M[10]=$5B : M[11]=$3F : M[12]=$5B : M[13]=$5B
;-------------------------------------------------------------------------------
D[0]=$01 : D[1]=$02 : D[2]=$04 : D[3]=$08
;-------------------------------------------------------------------------------
TM=14 : ND=4
;-------------------------------------------------------------------------------
INICIO:
    For I=0 To 3
        P[I]=0
    Next I
    
    For T=0 To TM+ND+1
        For I=ND-1 To 1 Step -1
            P[I]=P[I-1]
        Next I
        
        If T<=TM-1 Then
            P[0]=M[T]
        Else
            P[0]=0
        EndIf
        
        For J=1 To 40
            For I=0 To ND-1
                AUX=P[I]
                SHOut DS,CL,5,[AUX]
                ST=0 : DelayUS 10 : ST=1
                PORTB=D[I]
                DelayMS 2
                PORTB=0
            Next I
        Next J
    Next T
    
GoTo INICIO
    



