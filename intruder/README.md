# Find the intruder!!

From: [https://www.codeeval.com/open_challenges/137/](https://www.codeeval.com/open_challenges/137/)

## Challenge Description:

A company's server has been down for a couple of hours due to an unauthorized intrusion. After bringing it back live, a security department started to investigate the log files in order to find any trails of a hacker. Luck was on their side: they found a broken network log file containing pieces of useful data that could possibly help them identify an intruder. Among the garbage of ASCII uppercase and lowercase letters, punctuation marks, and digits, they found IP addresses in various formats.

## For example:

Dotted decimal  192.0.2.235 with no leading zero.
Dotted hexadecimal 0xc0.0x0.0x02.0xeb Each octet is individually converted to hexadecimal form.
Dotted octal 0300.0000.0002.0353 Each octet is individually converted into octal.
Dotted binary 11000000.00000000.00000010.11101011 Each octet is individually converted into binary.
Binary 11000000000000000000001011101011
Octal 030000001353
Hexadecimal 0xC00002EB  Concatenation of the octets from the dotted hexadecimal.
Decimal 3221226219  The 32-bit number expressed in decimal.

To help them finish their investigation and find the hacker, you need to find the most frequently occurring IP address in that file. You must search only for a valid IPv4 address in a range from 1.0.0.0 to 255.255.255.254.

The input sample below contains:

Valid IP addresses:
    1000000111011100010000001100101
    01000000.11101110.00100000.01100101
    034062405073
    023244514100
    033642264316
    222.137.104.206
    10110010011001001101100010111010
    0131.0345.0202.0341
    0x59.0xe5.0x82.0xe1
    89.229.130.225
    1011001111001011000001011100001
    89.229.130.225

Not valid IP addresses:
    1101100000.1001010111.101010101.1110010101
    864.599.341.917
    01540.01127.0525.01625
    0x360.0x257.0x155.0x395
    864.599.341.917
    864.599.341.917

The IP address 89.229.130.225 appears five times so it's the one we've been searching for.
Input sample:

Your program should accept as its first argument a path to a filename. The file contains the N number of lines with the length of M symbols.

## For example:

```
m*M}Qz`\fz/We}e[`md;Puuat-;UP|Yi64iXh%{Hnul8&onq0p*mY+4x\/{ZTw[gXeJV2&.P*Ywe
VA,8Z%z-AYzp6o{qeX3Q|\`Zw7{78:Y80qP-,b0BDVvZh60x59.0xe5.0x82.0xe1uptW8eF8C]nKJ9c(AtXa9>Dy}nF'Jr
Cq2ox2Mmr7PuaPO023244514100.@({-mER/yhWg)wsf"`Fu_tp.C]6$!?(^+wzLBxi,PJ41Hdu`m>Bz=v*^~N|h
jfZ&y9w'XkrrO6JDoZOyZ864.599.341.917JBJ5u(^i%BjecAd"$4UKtPnbtvx^01540.01127.0525.01625tU$HY/,Uw(/CJP]L+/XohV2hD&]
9Pl.1011001111001011000001011100001,Y,HNAiSzL;?BU_UQlCvyzRU^"R]{kVJ"[+3%PK`]\"V?;Y'8CjJ<&QGmESP6W7&P,@$tFtL
`z6DR}/>gLfLX[1&]Vr8"EG-_+wy?sw4beHIp^oTtZzvWBwY{[89.229.130.225R,?B;"?[ix4^9D$fVaJ_V\)N`B
=ddalCNOM)FnA=/r,?}#idpo1E#eeMq.wyfu/2viz;c_[kHppMh,K|\`Q1_R(`jRNvCZW2Niz7Q#
w:b21f[rsnj^Rgg[t!(<5v`Iup^&]o@489.229.130.225gw4\SwBEbN222.137.104.206[Jo<)lj36bB.034062405073xx37d;~wKi/D"I'AeVfeBO
|7$mi3k]f}9N*Vjq5aMy[Xd+3a$n$paB?5p9^01000000.11101110.00100000.01100101u@0:7&J;8FDZ<LuN-ecftQ%XU2urHk=N"y}1Zt+
|lLN|l8ZlMi()kN29/B!uj~l8#1o?Kcp/1{FfL]1/NsK$<@`)0P+LVgv4ziP>t840131.0345.0202.0341`}Z*Xz[8IH?'
^~H5]JqL#?>d8V5JPP1101100000.1001010111.101010101.11100101011Funfr=3*E\pEa"3YV^?J+;dLA#t)$3Lvi5J<MSF]LB&yOXgO't/E864.599.341.917Ze033642264316z~7
W7+1&dt2#Ek&<am6G|!!18P>?|?qQyV(0k?>KPB:t{IRUm>cuN0^[YSOsixxF"zzl5LALPIaXFM.
jMfgpfH+w>M8\`r{;`XdEYm0Rc7o>Aqq4k?gP>,O^2I^]OF#zN\cLSUQ(x!(oxA0l<xjM=-qcIXE
_L)a,<}f4u9dc]'440h0y7Yu=&NOfz-k%hk/FLpVZBsX|+P5YjaNBH]TCG~{,k]Dc\7p$)s&4D+Y
xI~0JkBd]}c#]!4eGec7oz>d:yYl*K_AK^Hd_<c+hjD4w:-[90?}lBZ]^@iT2A&i9=9tsjg3muNC
,6ze^#eqtjrd`P&?WY,J-]L)_gVR*NJ~]Q(#l"Yu~Jpl*ui"9JtZ=&2B{!6"iP@Y@3I%Zft>cpd`
OwEK!d?y\M(_L~|=lm1++BLA<&PnOnBAfga>t},x{T$*&/}+wX{j/pm'|N~Cq1000000111011100010000001100101x~[*Scc=lb82`K~
HydTS#@@864.599.341.917Q&.DVb\ails}C101100100110010011011000101110100&@KyFK"7}u3\63?u][~zz>-r$_OqUbE*uv,\ccCnUmP\<p,o4E6[7c]
v<md%aG2z8n'}"9}qwZYnHdo>`4/Ht!3puL.A\'].BA>reos{U0x360.0x257.0x155.0x395y^UGXh^'`|I.CV}R>a}RAhO%Vw
uQ#27/z^B8q:x(I|$k9dmF{\<ofV5sg[F>P(t!ui5[<mpXTzO%0wF|E2Sh6bl5[YZ:Tm%JsE*5pUO
```

## Output sample:

Print out the most frequently occurring IP address in a dotted decimal representation without leading zeros. In case there is more than one most frequently occuring IP address, then print them both out in ascending order separated by a white space.

For example:
Constraints:

    M is in range [100, 300]
    N is in range [800, 1200]
