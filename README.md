# Vesta OEM-188 Notes

Scott Baker, https://www.smbaker.com/

The Vesta OEM-188, also known as the Radio Electronics Robot "Brain", is a small
80188-based single board computer. It comes with 64 KB of RAM, expandable to
128 KB, and 4 ROM sockets. One of the ROMs has a built in EPROM programmer. It
also supports a UART, floppy drive, parallel interface, battery-backed memory, RTC,
and an expansion bus.

The computer has the FORTH language built in. Advertising literature implies there
was also a BASIC interpreter that was available.

The computer includes a BIOS that is sufficient to boot MS-DOS from floppy. However,
this BIOS does not emulate the text features necessary to use something like GWBASIC
or BASICA. The 64 KB (or 128 KB, if upgraded) memory environment is extermely
restrictive. These two limitations make it difficult to use anything other than
fairly trivial DOS programs, from the early age of the PC. It should be possible
to cross-compile DOS software using OpenWatcom or similar compiler, and produce some
interesting DOS applications to run.

# The Dip Switch

```
Note that my switch polarity is backwars from RE Magazine's article.

Switch 1
  1 = 64 KB Ram
  0 = 128 KB Ram

Switches 2, 3 and 4 seem to set the baud rate

111 = 150 (unverified)
110 = 300 (unverified)
101 = 600 (unverified)
100 = 1200 (unverified)
011 = 2400  (my notes had this as 1200)
010 = 4800
001 = 9600
000 = 19200
```

# Upgrading Memory

1. Desolder jumper AA and solder jumper BB

2. Break Jumpers 1-A13, 2-A14, 3-A15, 4-A16

3. Solder Jumpers 1-A14, A-A15, 3-A16, 4-A17

4. Move SW-1 from 1 to 0.

5. Install 62256 in the RAM sockets.

This will show as 128 KB RAM in DOS. It should be possible
to go to 256 KB by moving CC to DD as well. However, I think the
BIOS does not support memory > 128 KB.

# Reading DOS Disks

I used MS-DOS 2.10 / 2.11 via Gotek, and via a 360KB floppy drive. 720KB
disks may also work too.

Originally had lots of trouble with this, but eventually the problems went
away when I pulled the RAM chips and starting permuting them. First I shifted
them all right 2 places, then I repeated that and did it again. Possible bad
RAM chip, but still unverified -- I don't think the BIOS does a POST test
so bad RAM may go undetected until it's read in by the FDC and corrupted
in RAM (resulting in a bad boot)

Other things to check:

1. Pull all RAM chips and test them.

2. Reseat logic chips

3. Check position of SW1-1

Drive will seek tracks 0,1,2,3,4,5. Then maybe it goes back and seeks over
3,4,5 again.

BASICA and GWBASIC do not work right. Suspect video problem. All the character output
ends up jemmed into the bottom left corner.

Most DOS commands eemed to work fine. Things like CHKDSK, FREE, TYPE, etc.

# Using Forth

To boot into Forth, simple don't put a disk in the drive, and/or don't even plug
in the floppy. The computer will boot with the following:

```
Vesta Forth-83 04/08/87
```

From there, you can try a few basic forth operations, such as

```
1 2 +  ok
. 3  ok
```

The "ok" being printed by the FORTH interpreter when you hit <CR>.

# Forth Vocabulary

The Vesta OEM-188 has the following words:

```
>FORTH   >ASM   LABEL   WORDS   B   L   N   INDEX   TRIAD   LIST   ?CR   
?LINE   RMARGIN   LMARGIN   ENDCASE   ENDOF   OF   CASE   DUMP   EDUMP   
TERMINAL   (WHERE)   EDIT   EDITOR   DARK   AT   REPLACE   INSERT   
DELETE   SEARCH   .ID   .S   DEPTH   DISK   RAM   BYE   COLD   WARM   
QUIT   USER   #USER   BACKGROUND:   ACTIVATE   SET-TASK   TASK:   STOP   
WAKE   SLEEP   LOCAL   SINGLE   PAUSE   ROOT   IS   CODE   2VARIABLE   
2CONSTANT   DEFINITIONS   VOCABULARY   DEFER   VARIABLE   CONSTANT   
RECURSIVE   ;   :   ]   [   DOES>   ;CODE   ;USES   ASSEMBLER   REVEAL   
HIDE   ?CSP   !CSP   CREATE   WHILE   ELSE   IF   REPEAT   AGAIN   
UNTIL   +LOOP   LOOP   ?DO   DO   THEN   BEGIN   ?LEAVE   LEAVE   
?<RESOLVE   ?<MARK   ?>RESOLVE   ?>MARK   <RESOLVE   <MARK   >RESOLVE   
>MARK   ?CONDITION   ABORT   ABORT"   (?ERROR)   ?ERROR   WHERE   
FORGET   FENCE   "   ."   [COMPILE]   [']   '   CONTROL   ASCII   
DLITERAL   LITERAL   IMMEDIATE   COMPILE   C,   ,   ALLOT   INTERPRET   
STATUS   ?UPPERCASE   FIND   >NAME   >BODY   NAME>   FORTH-83   
TRAVERSE   \S   (S   (   .(   WORD   PARSE   PARSE-WORD   SOURCE   
(SOURCE)   PLACE   /STRING   SCAN   SKIP   D.R   D.   UD.R   UD.   .R   
.   U.R   U.   DECIMAL   HEX   #S   #   SIGN   #>   <#   HOLD   NUMBER   
(NUMBER)   NUMBER?   (NUMBER?)   CONVERT   DOUBLE?   DIGIT   WBIOS   
RBIOS   TO   CONVEY   COPY   FLUSH   SAVE-BUFFERS   EMPTY-BUFFERS   
BLOCK   BUFFER   UPDATE   PROGRAM   EPROM   -->   THRU   ?ENOUGH   \   
WRITE-BLOCK   READ-BLOCK   BUFFER#   >BUFFERS   FIRST   LIMIT   
DISK-ERROR   B/BUF   QUERY   TIB   EXPECT   CC   DEL-IN   CHAR   
(CHAR)   BACKSPACES   SPACES   SPACE   TYPE   CRLF   (EMIT)   (PRINT)   
CR   KEY   KEY?   (CONSOLE)   (KEY)   (KEY?)   PC!   PC@   LOAD   
(LOAD)   COMPARE   -TRAILING   PAD   HERE   UPPER   UPC   MOVE   COUNT   
BLANK   ERASE   FILL   CAPS   BL   #TIB   SPAN   >IN   BLK   VOC-LINK   
WIDTH   'TIB   (CON)   CONTEXT   (CUR)   CURRENT   CSP   LAST   R#   
DPL   WARNING   STATE   SCR   RP0   SP0   EMIT   PRINTING   HLD   BASE   
OFFSET   #LINE   #OUT   DP   TOS   LINK   ENTRY   */   */MOD   MOD   /   
/MOD   *   MU/MOD   M/MOD   DMAX   DMIN   D>   D<   DU<   D=   D0=   
?DNEGATE   D-   D2/   D2*   DABS   S>D   DNEGATE   D+   2ROT   2OVER   
2SWAP   2DUP   2DROP   2!   2@   WITHIN   BETWEEN   >=   <=   U>=   
U<=   MAX   MIN   ?NEGATE   <>   >   <   U>   U<   =   0<>   0>   0<   
0=   UM/MOD   *D   UM*   2-   1-   2+   1+   U2/   2/   2*   +!   ABS   
-   NEGATE   +   OFF   ON   FALSE   TRUE   NOT   XOR   OR   AND   ROLL   
PICK   R@   >R   R>   ?DUP   -ROT   ROT   NIP   TUCK   OVER   SWAP   
DUP   DROP   RP!   RP@   SP!   SP@   CMOVE>   CMOVE   E!   EC!   E@   
EC@   C!   C@   !   @   J   I   MCALL   NOOP   PERFORM   EXECUTE   
BOUNDS   ?BRANCH   BRANCH   UP   EXIT   FORTH
```

# Documentation

The documentation on the OEM-188. The original series of articles
from Radio Electronics Magazine ran in 1987. These issues are available
at archive.org and can be downloaded freely. In particular the
April and August articles have useful information on the OEM-188.

IF you have any documentation above and beyond the Radio Electronics
articles, please leave me a comment at https://www.smbaker.com/ (you can
just drop a wordpress comment and it will find its way to me). Alternatively
you could open a ticket here on github and it'll wake me up.
