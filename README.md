# Oberon-07-Math.ln
## A corrected implementation of Math.ln(x) for Project Oberon 2013.

Unfortunately the standard ln(x) (natural logarithm) function of module Math does not give very accurate results.

This is an improved implementation of the function for 32-bit type REAL. It gives at least 7 correct significant digits for every x > 0.

With the help of two older Oberon implementations I was able to figure out this corrected version of Math.ln(x). My target was a function in the spirit of the present one, that uses the UNPK(x, e) standard procedure, and that doesn't need SYSTEM. The new version turns out to be even simpler than the present one.

The file Math1.ln.Mod contains the new version, and also a refinement by Jörg Straube, making it even more elegant.

This repository also shows the two older Oberon implementations: the files Math.Mod.Griebling and Math.ModETH3 contain the ln(x) function in their complete Oberon (1990) Math.Mod context. The files Math1.ln.Mod.Griebling and Math1.ln.Mod.ETH3 contain my ports to Oberon-07 of these older ln(x) functions which helped me to find the final Oberon-07 implementation.

TestMath.Mod provides a test suite for all the functions of Math.Mod. You can use this to verify the results and compare them with results of a calculator or of [Wolfram Alpha](https://www.wolframalpha.com).
