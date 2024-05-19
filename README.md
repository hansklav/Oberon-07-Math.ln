# Oberon-07-Math.ln
## A corrected implementation of Math.ln(x) for Project Oberon 2013.

Unfortunately the standard ln(x) function of module Math does not give very accurate results.

This is an improved implementation for 32-bit type REAL that gives at least 7 correct digits for every x > 0.

With the help of two older Oberon implementations I was able to figure out a correct version of Math.ln(x) which also uses the UNPK(x, e) standard procedure, and doesn't need to import SYSTEM. The new correct version turns out to be even simpler than the present one.

The file Math.ln.Mod contains the new version. 

I also show the two older implementations: the files MathGriebling.Mod  and MathETH3.Mod contain the the ln(x) function in their complete Math.Mod context. The files Math1Griebling.Mod and Math1ETH3.Mod contain my ports to Oberon-07 without use of UNPK which helped me to find the final implementation.

TestMath.Mod provides a test suite for all the functions of Math.Mod. You can use this to verify the results and compare them with results of a calculator or of (Wolfram Alpha)[https://www.wolframalpha.com].
