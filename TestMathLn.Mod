(* TestMath.Ln *)

MODULE TestMathLn;
(* Test for the Mathln function. 
   Verify the results here: 
     https://www.wolframalpha.com
     https://float.exposed
*)

  IMPORT Fonts, Texts, Oberon, Math, Math1; 

  VAR W: Texts.Writer;

  PROCEDURE Ln *;
    VAR x: REAL;
  BEGIN 
    Texts.SetFont(W, Fonts.This("Courier10.Fnt"));
    Texts.WriteString(W, "       x            ln(x)   ");  Texts.WriteLn(W);
    x := 1.0;
    WHILE x <= 100.0 DO  
      Texts.WriteReal(W, x,15);  Texts.WriteReal(W, Math1.ln(x),15);  Texts.WriteLn(W);
      x := x + 1.0
    END;
    Texts.Append(Oberon.Log, W.buf)
  END Ln;

BEGIN 
  Texts.OpenWriter(W)
END TestMathLn.

