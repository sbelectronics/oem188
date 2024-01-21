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

